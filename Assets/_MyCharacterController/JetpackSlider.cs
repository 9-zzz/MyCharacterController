using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class JetpackSlider : MonoBehaviour
{

    public Slider jpSlider;

    void Awake()
    {
        jpSlider = this.GetComponent<Slider>();
    }

    // Use this for initialization
    void Start()
    {
        jpSlider.maxValue = Jetpack.S.maxFuel;
    }

    // Update is called once per frame
    void Update()
    {
        jpSlider.value = Jetpack.S.fuel;
    }

}
