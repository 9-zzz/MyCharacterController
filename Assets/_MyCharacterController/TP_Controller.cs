using UnityEngine;
using System.Collections;

/*
 * Brains/Overseer of the character, take in player input.
 * Motion inputs into 3D vectors. Initial setup check
 * is camera ready to go? Makes sure camera is there.
 * Constant checks for camera existence, if no camera, stops.
 * Force updates the TP_Motor class.
 * Housekeeping. References: Unity Character Controller
 * Reference to self, Singleton, easy ref from elsewhere.
 */
public class TP_Controller : MonoBehaviour
{
    public static CharacterController CharacterController;
    public static TP_Controller Instance;
    public float deadZone = 0.001f; // Changed from original code, exposed

    void Awake()
    {
        //CharacterController = GetComponent("CharacterController") as CharacterController; // Original code.
        CharacterController = GetComponent<CharacterController>();
        Instance = this;
    }

    void Update()
    {
        // If no camera, stop taking any input, disable Update()
        if (Camera.main == null)
            return;

        GetMovementInput();
        HandleActionInput(); // Called in every update as long as camera exists

        // Public UpdateMotor(), force motor update AFTER we set MoveVector
        TP_Motor.Instance.UpdateMotor();
    }

    void GetMovementInput()
    {
        TP_Motor.Instance.VerticalVelocity = TP_Motor.Instance.MoveVector.y;

        // Maybe interpolate to zero instead of having abrupt stop
        // Keeps motion from becoming additive. Every frame is recalculated
        TP_Motor.Instance.MoveVector = Vector3.zero;

        if (Input.GetAxis("Vertical") > deadZone || Input.GetAxis("Vertical") < -deadZone)
            TP_Motor.Instance.MoveVector += new Vector3(0, 0, Input.GetAxis("Vertical"));

        if (Input.GetAxis("Horizontal") > deadZone || Input.GetAxis("Horizontal") < -deadZone)
            TP_Motor.Instance.MoveVector += new Vector3(Input.GetAxis("Horizontal"), 0, 0);

        TP_Animator.Instance.DetermineCurrentMoveDirection();//specifically at the end of this function since we have movevector
    }

    void HandleActionInput()
    {
        if (Input.GetButtonDown("Jump"))
            Jump();
    }

    void Jump()//opening up a lot of possibilities to what to do , anything linked to jump
    {
        //or sound effect, everytime jump happens . do something here
        TP_Motor.Instance.Jump();//tp controller is the brain. need this for animation and stuff
    }

}
