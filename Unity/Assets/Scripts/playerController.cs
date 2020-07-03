using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerController : MonoBehaviour
{
    private interactable interactScript;
    public bool isInteracting = false;
    private GameObject player;
    Rigidbody rb;
    public float speed;
    public float rotSpeed;
    private Vector3 moveDirection = Vector3.zero;
    public float insanity = 0.0f;
    public bool isMoving = false;
    
    void Start(){
        rb = GetComponent<Rigidbody>();
    }
    
    void Update(){
        //HEAD BOB LOGIC
       	if (Input.GetKey(KeyCode.LeftArrow) || Input.GetKey(KeyCode.A) || Input.GetKey(KeyCode.RightArrow) || Input.GetKey(KeyCode.D) || Input.GetKey(KeyCode.UpArrow) || Input.GetKey(KeyCode.W) || Input.GetKey(KeyCode.DownArrow) || Input.GetKey(KeyCode.S)){
       	    isMoving = true;       
     	}else{
       	    isMoving = false;
   	    }
        /*
      	if(isInteracting){
            //lock playher
            rb.constraints = RigidbodyConstraints.FreezePositionX | RigidbodyConstraints.FreezePositionY | RigidbodyConstraints.FreezePositionZ | RigidbodyConstraints.FreezeRotationY;
            this.GetComponentInChildren<BoxCollider>().enabled = false;
            isMoving = false;

	        }else{
                //UNLOCK ROT
                rb.constraints = RigidbodyConstraints.None;
                rb.constraints = RigidbodyConstraints.FreezePositionY;
                this.GetComponentInChildren<BoxCollider>().enabled = true;
            }*/

            rotPlayer();

    //MOVEMENT
    void rotPlayer(){
        float moveHorizontal = Input.GetAxisRaw ("Horizontal");
        float moveVertical = Input.GetAxisRaw ("Vertical");
        
        Vector3 movement = new Vector3((moveHorizontal * (-1)), 0.0f, (moveVertical * (-1)));
        
        if (isMoving){
            //Rotate Player
            transform.rotation = Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(movement * (-1)), 0.5F);
            //Quaternion.Euler(0.0f, 5.0f, 0.0f);
        }
        
        transform.Translate (movement * speed * Time.deltaTime, Space.World);
        }
    }
}

