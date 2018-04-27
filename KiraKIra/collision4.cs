using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class collision4 : MonoBehaviour
{
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
        GameObject unt4 = GameObject.Find("Sphere4");//Sphere4のオブジェクトをunt4に代入
        GameObject unt5 = GameObject.Find("Sphere5");//Sphere5のオブジェクトをunt5に代入
        GameObject unt6 = GameObject.Find("Sphere6");//Sphere6のオブジェクトをunt6に代入
        GameObject unt7 = GameObject.Find("Sphere7");//Sphere7のオブジェクトをunt7に代入

/*------------------------------------------------------------線をひく、消す-----------------------------------------------------------------*/
        /*Sphere1とSphere5をつなぐ線のカウントが1の時、線をひく*/
        if (c5 % 2 == 1)
        {
            var lineY45 = GameObject.Find("LineObject45").GetComponent<LineRenderer>();
            lineY45.enabled = true;
            lineY45.SetPosition(0, unt4.transform.position);
            lineY45.SetPosition(1, unt5.transform.position);
        }
        if(c5 % 2 == 0)
        {
            var lineY45 = GameObject.Find("LineObject45").GetComponent<LineRenderer>();
            lineY45.enabled = false;
        }
        /*Sphere1とSphere6をつなぐ線のカウントが1の時、線をひく*/
        if (c6 % 2 == 1)
        {
            var lineY46 = GameObject.Find("LineObject46").GetComponent<LineRenderer>();
            lineY46.enabled = true;
            lineY46.SetPosition(0, unt4.transform.position);
            lineY46.SetPosition(1, unt6.transform.position);
        }
        if(c6 % 2 == 0)
        {
            var lineY46 = GameObject.Find("LineObject46").GetComponent<LineRenderer>();
            lineY46.enabled = false;
        }
        /*Sphere1とSphere7をつなぐ線のカウントが1の時、線をひく*/
        if (c7 % 2 == 1)
        {
            var lineY47 = GameObject.Find("LineObject47").GetComponent<LineRenderer>();
            lineY47.enabled = true;
            lineY47.SetPosition(0, unt4.transform.position);
            lineY47.SetPosition(1, unt7.transform.position);
        }
        if(c7 % 2 == 0)
        {
            var lineY47 = GameObject.Find("LineObject47").GetComponent<LineRenderer>();
            lineY47.enabled = false;
        }

        if (Input.GetKey(KeyCode.R)){
          c5 = 0;//Sphere1とSphere5をつなぐ線のカウント
          c6 = 0;//Sphere1とSphere6をつなぐ線のカウント
          c7 = 0;
          Debug.Log("Rキーを押した");
}
    }
    /*オブジェクト同士の衝突を判定*/
    void OnCollisionEnter(Collision collision)
    {
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
