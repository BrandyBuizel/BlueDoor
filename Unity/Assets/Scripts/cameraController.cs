using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class cameraController : MonoBehaviour {
    private float x;
    private float y;
    private Vector3 rotateValue;
    public float sensitivity = 0.5f;
    public float smoothing = 1.0f;
    public float speed = 120.0f;
    public float rotX = 0;
    public float rotY = 0;
    public bool moveCamera = true; 


    void Start()
    {
        moveCamera = true;
    }

    void Update()
    {
        //Keyboard
        if (moveCamera == true)
        {
            if (Input.GetKey(KeyCode.DownArrow) || Input.GetAxis("Vertical") < 0)
            {
                transform.Rotate(new Vector3(speed * Time.deltaTime, 0, 0));

            }
            if (Input.GetKey(KeyCode.UpArrow) || Input.GetAxis("Vertical") > 0)
            {
                transform.Rotate(new Vector3(-speed * Time.deltaTime, 0, 0));
            }
            if (Input.GetKey(KeyCode.LeftArrow) || Input.GetAxis("Horizontal") < 0)
            {
                transform.Rotate(new Vector3(0, -speed * Time.deltaTime, 0));
            }
            if (Input.GetKey(KeyCode.RightArrow) || Input.GetAxis("Horizontal") > 0)
            {
                transform.Rotate(new Vector3(0, speed * Time.deltaTime, 0));
            }

            //WASD
            if (Input.GetKey(KeyCode.S))
            {
                transform.Rotate(new Vector3(speed * Time.deltaTime, 0, 0));

            }
            if (Input.GetKey(KeyCode.W))
            {
                transform.Rotate(new Vector3(-speed * Time.deltaTime, 0, 0));

            }
            if (Input.GetKey(KeyCode.A))
            {
                transform.Rotate(new Vector3(0, -speed * Time.deltaTime, 0));

            }
            if (Input.GetKey(KeyCode.D))
            {
                transform.Rotate(new Vector3(0, speed * Time.deltaTime, 0));

            }

            rotX = Input.GetAxis("Horizontal");

            rotY = Input.GetAxis("Vertical");

            //Lock Z
            float z = transform.eulerAngles.z;
            transform.Rotate(0, 0, -z);
        }

    }
}
