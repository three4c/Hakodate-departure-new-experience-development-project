using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class collision : MonoBehaviour
{
    int c2 = 0;//Sphere1とSphere2をつなぐ線のカウント
    int c3 = 0;//Sphere1とSphere3をつなぐ線のカウント
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
        GameObject unt1 = GameObject.Find("Sphere1");//Sphere1のオブジェクトをunt1に代入
        GameObject unt2 = GameObject.Find("Sphere2");//Sphere2のオブジェクトをunt2に代入
        GameObject unt3 = GameObject.Find("Sphere3");//Sphere3のオブジェクトをunt3に代入
        GameObject unt4 = GameObject.Find("Sphere4");//Sphere4のオブジェクトをunt4に代入
        GameObject unt5 = GameObject.Find("Sphere5");//Sphere5のオブジェクトをunt5に代入
        GameObject unt6 = GameObject.Find("Sphere6");//Sphere6のオブジェクトをunt6に代入
        GameObject unt7 = GameObject.Find("Sphere7");//Sphere7のオブジェクトをunt7に代入

/*------------------------------------------------------------線をひく、消す-----------------------------------------------------------------*/
        /*Sphere1とSphere2をつなぐ線のカウントが1の時線をひく*/
        if (c2 % 2 == 1)
         {
           var lineY12 = GameObject.Find("LineObject12").GetComponent<LineRenderer>();//LineObjectをlineY12に代入
           lineY12.enabled = true;//enableがtrueだとオブジェクトを可視化する
           lineY12.SetPosition(0, unt1.transform.position);
           lineY12.SetPosition(1, unt2.transform.position);
         }
        /*Sphere1とSphere2をつなぐ線のカウントが0の時線を消す*/
        if(c2 % 2 == 0){
          var lineY12 = GameObject.Find("LineObject12").GetComponent<LineRenderer>();
          lineY12.enabled = false;
        }
        /*Sphere1とSphere３をつなぐ線のカウントが1の時線をひき、0のとき線を消す*/
        if (c3 % 2 == 1)
        {
            var lineY13 = GameObject.Find("LineObject13").GetComponent<LineRenderer>();
            lineY13.enabled = true;
            lineY13.SetPosition(0, unt1.transform.position);
            lineY13.SetPosition(1, unt3.transform.position);
        }

        if(c3 % 2 == 0)
        {
            var lineY13 = GameObject.Find("LineObject13").GetComponent<LineRenderer>();
            lineY13.enabled = false;
        }


        /*Sphere1とSphere4をつなぐ線のカウントが1の時、線をひく*/
        if (c4 % 2 == 1)
        {
            var lineY14 = GameObject.Find("LineObject14").GetComponent<LineRenderer>();
            lineY14.enabled = true;
            lineY14.SetPosition(0, unt1.transform.position);
            lineY14.SetPosition(1, unt4.transform.position);
        }
        if(c4 % 2 == 0)
        {
            var lineY14 = GameObject.Find("LineObject14").GetComponent<LineRenderer>();
            lineY14.enabled = false;
        }
        /*Sphere1とSphere5をつなぐ線のカウントが1の時、線をひく*/
        if (c5 % 2 == 1)
        {
            var lineY15 = GameObject.Find("LineObject15").GetComponent<LineRenderer>();
            lineY15.enabled = true;
            lineY15.SetPosition(0, unt1.transform.position);
            lineY15.SetPosition(1, unt5.transform.position);
        }
        if(c5 % 2 == 0)
        {
            var lineY15 = GameObject.Find("LineObject15").GetComponent<LineRenderer>();
            lineY15.enabled = false;
        }
        /*Sphere1とSphere6をつなぐ線のカウントが1の時、線をひく*/
        if (c6 % 2 == 1)
        {
            var lineY16 = GameObject.Find("LineObject16").GetComponent<LineRenderer>();
            lineY16.enabled = true;
            lineY16.SetPosition(0, unt1.transform.position);
            lineY16.SetPosition(1, unt6.transform.position);
        }
        if(c6 % 2 == 0)
        {
            var lineY16 = GameObject.Find("LineObject16").GetComponent<LineRenderer>();
            lineY16.enabled = false;
        }
        /*Sphere1とSphere7をつなぐ線のカウントが1の時、線をひく*/
        if (c7 % 2 == 1)
        {
            var lineY17 = GameObject.Find("LineObject17").GetComponent<LineRenderer>();
            lineY17.enabled = true;
            lineY17.SetPosition(0, unt1.transform.position);
            lineY17.SetPosition(1, unt7.transform.position);
        }
        if(c7 % 2 == 0)
        {
            var lineY17 = GameObject.Find("LineObject17").GetComponent<LineRenderer>();
            lineY17.enabled = false;
        }

        if (Input.GetKey(KeyCode.R)){
          c2 = 0;//Sphere1とSphere2をつなぐ線のカウント
          c3 = 0;//Sphere1とSphere3をつなぐ線のカウント
          c4 = 0;//Sphere1とSphere4をつなぐ線のカウント
          c5 = 0;//Sphere1とSphere5をつなぐ線のカウント
          c6 = 0;//Sphere1とSphere6をつなぐ線のカウント
          c7 = 0;

         }

         //Debug.Log(c2);
    }
    /*オブジェクト同士の衝突を判定*/
    void OnCollisionEnter(Collision collision)
    {
      　/*Sphere1とSphere2が衝突したらカウント*/
        if (collision.gameObject.name == "Sphere2")
        {
            c2 += 1;
            audioSouse.Play();
        }

　　　　/*Sphere1とSphere3が衝突したらカウント*/
        if (collision.gameObject.name == "Sphere3")
        {
            c3 += 1;
            audioSouse.Play();
        }
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
