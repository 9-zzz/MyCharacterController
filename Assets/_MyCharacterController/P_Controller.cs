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
public class P_Controller : MonoBehaviour
{
    public static CharacterController CharacterController;
    public static P_Controller Instance;
    public float deadZone = 0.001f; // Changed from original code, exposed

    void Awake()
    {
        //CharacterController = GetComponent("CharacterController") as CharacterController; // Original code.
        CharacterController = GetComponent<CharacterController>();
        Instance = this;
        //P_Camera.UseExistingOrCreateNewMainCamera();
    }

    void Update()
    {
        // If no camera, stop taking any input, disable Update()
        if (Camera.main == null)
            return;

        GetMovementInput();  // 1st
        HandleActionInput(); // 2nd Called in every update as long as camera exists

        // Public UpdateMotor(), force motor update AFTER we set MoveVector
        P_Motor.Instance.UpdateMotor();
    }

    void GetMovementInput()
    {
        // We have to save our verical compoenent before we zero it out ???
        // Otherwise we'll just be repeating the same part of gravity, no accelleration, slow gravity ???
        P_Motor.Instance.VerticalVelocity = P_Motor.Instance.MoveVector.y;

        // Maybe interpolate to zero instead of having abrupt stop
        // Keeps motion from becoming additive. Every frame is recalculated
        P_Motor.Instance.MoveVector = Vector3.zero;

        if (Input.GetAxis("Vertical") > deadZone || Input.GetAxis("Vertical") < -deadZone)
            P_Motor.Instance.MoveVector += new Vector3(0, 0, Input.GetAxis("Vertical"));

        if (Input.GetAxis("Horizontal") > deadZone || Input.GetAxis("Horizontal") < -deadZone)
            P_Motor.Instance.MoveVector += new Vector3(Input.GetAxis("Horizontal"), 0, 0);

        P_Animator.Instance.DetermineCurrentMoveDirection();//specifically at the end of this function since we have movevector
    }

    // Put all stuff in here, future flexible, animations
    void HandleActionInput()
    {
        if (Input.GetButtonDown("Jump"))
            Jump();
    }

    void Jump() // Opening up a lot of possibilities to what to do , anything linked to jump
    {
        // Or sound effect, everytime jump happens . do something here
        P_Motor.Instance.Jump(); // P_Controller is the brain. need this for animation and stuff
    }

}
