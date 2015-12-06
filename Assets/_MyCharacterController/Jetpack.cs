using UnityEngine;
using System.Collections;

public class Jetpack : MonoBehaviour
{
    public static Jetpack S;

    public float fuel;
    public float maxFuel;
    P_Motor motor;
    CharacterController cc;
    public bool isAirbourne = false;

    void Awake()
    {
        Helper.TestFunction();
        S = this;
    }

    // Use this for initialization
    void Start()
    {
        motor = GetComponent<P_Motor>();
        cc = GetComponent<CharacterController>();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.LeftShift))
            isAirbourne = true;
        if (Input.GetKeyUp(KeyCode.LeftShift))
            isAirbourne = false;

        if (isAirbourne)
        {
            fuel -= Time.deltaTime;
            if (fuel < 0)
            {
                fuel = 0;
                isAirbourne = false;
            }
            motor.MoveVector = new Vector3(cc.velocity.x, 10.0f, cc.velocity.z);
        }
        else if (fuel < maxFuel)
        {
            fuel += Time.deltaTime;
        }
    }

}
