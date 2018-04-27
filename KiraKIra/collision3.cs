using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class collision3 : MonoBehaviour
{
    int c4 = 0;//Sphere1とSphere4をつなぐ線のカウント
    int c5 = 0;//Sphere1とSphere5をつなぐ線のカウント
    int c6 = 0;//Sphere1とSphere6をつなぐ線のカウント
    int c7 = 0;//Sphere1とSphere7をつなぐ線のカウント

    public AudioClip sound;
    private AudioSource audioSouse;


    void Start()
    {
      audioSouse = gameObject.AddComponent<AudioSource>();
      audioSouse.clip = sound;
    }

    void Update()
    {
        GameObject unt3 = GameObject.Find("Sphere3");//Sphere3のオブジェクトをunt3に代入
        GameObject unt4 = GameObject.Find("Sphere4");//Sphere4のオブジェクトをunt4に代入
        GameObject unt5 = GameObject.Find("Sphere5");//Sphere5のオブジェクトをunt5に代入
        GameObject unt6 = GameObject.Find("Sphere6");//Sphere6のオブジェクトをunt6に代入
        GameObject unt7 = GameObject.Find("Sphere7");//Sphere7のオブジェクトをunt7に代入

/*------------------------------------------------------------線をひく、消す-----------------------------------------------------------------*/
        /*Sphere1とSphere4をつなぐ線のカウントが1の時、線をひく*/
        if (c4 % 2 == 1)
        {
            var lineY34 = GameObject.Find("LineObject34").GetComponent<LineRenderer>();
            lineY34.enabled = true;
            lineY34.SetPosition(0, unt3.transform.position);
            lineY34.SetPosition(1, unt4.transform.position);
        }
        if(c4 % 2 == 0)
        {
            var lineY34 = GameObject.Find("LineObject34").GetComponent<LineRenderer>();
            lineY34.enabled = false;
        }
        /*Sphere1とSphere5をつなぐ線のカウントが1の時、線をひく*/
        if (c5 % 2 == 1)
        {
            var lineY35 = GameObject.Find("LineObject35").GetComponent<LineRenderer>();
            lineY35.enabled = true;
            lineY35.SetPosition(0, unt3.transform.position);
            lineY35.SetPosition(1, unt5.transform.position);
        }
        if(c5 % 2 == 0)
        {
            var lineY35 = GameObject.Find("LineObject35").GetComponent<LineRenderer>();
            lineY35.enabled = false;
        }
        /*Sphere1とSphere6をつなぐ線のカウントが1の時、線をひく*/
        if (c6 % 2 == 1)
        {
            var lineY36 = GameObject.Find("LineObject36").GetComponent<LineRenderer>();
            lineY36.enabled = true;
            lineY36.SetPosition(0, unt3.transform.position);
            lineY36.SetPosition(1, unt6.transform.position);
        }
        if(c6 % 2 == 0)
        {
            var lineY36 = GameObject.Find("LineObject36").GetComponent<LineRenderer>();
            lineY36.enabled = false;
        }
        /*Sphere1とSphere7をつなぐ線のカウントが1の時、線をひく*/
        if (c7 % 2 == 1)
        {
            var lineY37 = GameObject.Find("LineObject37").GetComponent<LineRenderer>();
            lineY37.enabled = true;
            lineY37.SetPosition(0, unt3.transform.position);
            lineY37.SetPosition(1, unt7.transform.position);
        }
        if(c7 % 2 == 0)
        {
            var lineY37 = GameObject.Find("LineObject37").GetComponent<LineRenderer>();
            lineY37.enabled = false;
        }

        if (Input.GetKey(KeyCode.R)){
          c4 = 0;//Sphere1とSphere4をつなぐ線のカウント
          c5 = 0;//Sphere1とSphere5をつなぐ線のカウント
          c6 = 0;//Sphere1とSphere6をつなぐ線のカウント
          c7 = 0;
          Debug.Log("Rキーを押した");
}
    }
    /*オブジェクト同士の衝突を判定*/
    void OnCollisionEnter(Collision collision)
    {
        /*Sphere1とSphere4が衝突したらカウント*/
        if (collision.gameObject.name == "Sphere4")
        {
            c4 += 1;
            audioSouse.Play();
        }
        /*Sphere1とSphere5が衝突したらカウント*/
        if (collision.gameObject.name == "Sphere5")
        {
            c5 += 1;
            audioSouse.Play();
        }
        /*Sphere1とSphere6が衝突したらカウント*/
        if (collision.gameObject.name == "Sphere6")
        {
            c6 += 1;
            audioSouse.Play();
        }
        /*Sphere1とSphere7が衝突したらカウント*/
        if (collision.gameObject.name == "Sphere7")
        {
            c7 += 1;
            audioSouse.Play();
        }
      }
}
