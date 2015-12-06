using UnityEngine;
using UnityEngine.UI;
using System.Collections;

/*
 * Process motion data received from TP_Controller
 * Make things based on seconds not computer cycles
 * Solves Fast Diagonals *** //mark where later
 * Maintain character's rotation relative to the camera.
 * All motion relative to where camera is facing.
 */
public class P_Motor : MonoBehaviour
{
    public static P_Motor Instance;

    public int baseNumOfJumps = 2;        // My custom addition
    public int numOfJumps;                // My custom addition
    public float Gravity = 31f;
    public float TerminalVelocity = 20f; // Max speed at which gravity can be applied
    public float JumpSpeed = 6f;
    public float SlideSpeed = 10f;
    public float ForwardSpeed = 10f;
    public float BackwardSpeed = 2f;
    public float StrafingSpeed = 5f;
    public float SlideThreshold = 0.6f;
    public float MaxControllableSlideMagnitude = 0.4f;

    private Vector3 slideDirection;

    public Vector3 MoveVector { get; set; }
    public float VerticalVelocity { get; set; } // Jetpack variable?

    void Awake()
    {
        numOfJumps = baseNumOfJumps;
        Instance = this;
    }

    public void UpdateMotor()
    {
        SnapAllignCharacterWithCamera(); // 1st
        ProcessMotion();                 // 2nd
    }

    void ProcessMotion()
    {
        // Transform MoveVector into WorldSpace relative to our character's rotation
        MoveVector = transform.TransformDirection(MoveVector);

        // Then normalize our movevector if our magnitude is greater than 0, Fixes diagonal speed problem
        if (MoveVector.magnitude > 1)
            MoveVector = Vector3.Normalize(MoveVector);

        // Apply sliding important placement
        ApplySlide();

        // Multiply movevector by movespeed
        MoveVector *= MoveSpeed();// Now a method, transmission
        // ^### could apply dash methodology here, save loves of code?

        // multiply  movevector by delta.time for value per second than per frame
        // MoveVector *= Time.deltaTime;//moved down, was for clarification

        // Reapply Vertical Velocity.y
        MoveVector = new Vector3(MoveVector.x, VerticalVelocity, MoveVector.z);

        ApplyGravity();

        // Move the character in worldspace
        P_Controller.CharacterController.Move(MoveVector * Time.deltaTime); // Meters per frame update to meters per second <- Time.deltaTime

    } // End of ProcessMotion()

    void ApplyGravity()
    {
        if (MoveVector.y > -TerminalVelocity)
            MoveVector = new Vector3(MoveVector.x, MoveVector.y - Gravity * Time.deltaTime, MoveVector.z);

        if (P_Controller.CharacterController.isGrounded && MoveVector.y < -1)
        {
            MoveVector = new Vector3(MoveVector.x, -1, MoveVector.z);
            numOfJumps = baseNumOfJumps; // My addition for double jumping and resetting jumps.
        }
    }

    void ApplySlide()
    {
        if (!P_Controller.CharacterController.isGrounded)//if not grounded do nothing
            return;

        slideDirection = Vector3.zero;

        RaycastHit hitInfo;

        //cast from 0,1,0 + trans pos, to 0,-1,0 and put out into hitInfo
        if (Physics.Raycast(transform.position + Vector3.up, Vector3.down, out hitInfo))
        {
            Debug.DrawLine(transform.position + Vector3.up, Vector3.down);

            if (hitInfo.normal.y < SlideThreshold)
                slideDirection = new Vector3(hitInfo.normal.x, -hitInfo.normal.y, hitInfo.normal.z);
        }

        if (slideDirection.magnitude < MaxControllableSlideMagnitude)
        {
            MoveVector += slideDirection;
        }
        else
        {
            MoveVector = slideDirection;
        }

    } // End of ApplySlide()

    public void Jump()
    {
        if (numOfJumps > 0)
        {
            VerticalVelocity = JumpSpeed;
            numOfJumps--;
        }

        //if (numOfJumps > 0) { numOfJumps--; VerticalVelocity = JumpSpeed; }
    }

    void SnapAllignCharacterWithCamera()
    {
        // If we are we moving, rotate this object to match MainCamera's Y-rotation.
        // Possibly remove if and lerp the rotation to always math MainCamera rotation.
        if (MoveVector.x != 0 || MoveVector.z != 0)
            transform.rotation = Quaternion.Euler(transform.eulerAngles.x, Camera.main.transform.eulerAngles.y, transform.eulerAngles.z);
    }

    float MoveSpeed()
    {
        var moveSpeed = 0f; // Local var, need

        switch (P_Animator.Instance.MoveDirection)
        {
            case P_Animator.Direction.Stationary:
                //moveSpeed /= 1.09f;
                // Lerp moveSpeed to zero for smoother zeroing motion?
                moveSpeed = 0;
                break;

            case P_Animator.Direction.Forward:
                moveSpeed = ForwardSpeed;
                break;

            case P_Animator.Direction.Backward:
                moveSpeed = BackwardSpeed;
                break;

            case P_Animator.Direction.Left:
                moveSpeed = StrafingSpeed;
                break;

            case P_Animator.Direction.Right:
                moveSpeed = StrafingSpeed;
                break;

            case P_Animator.Direction.LeftForward:
                moveSpeed = ForwardSpeed;
                break;

            case P_Animator.Direction.RightForward:
                moveSpeed = ForwardSpeed;
                break;


            case P_Animator.Direction.LeftBackward:
                moveSpeed = ForwardSpeed;
                break;

            case P_Animator.Direction.RightBackward:
                moveSpeed = ForwardSpeed;
                break;
        }

        if (slideDirection.magnitude > 0)
            moveSpeed = SlideSpeed;

        return moveSpeed;

    } // End of MoveSpeed()

}//End of class
