using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class collision5 : MonoBehaviour
{
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
        GameObject unt5 = GameObject.Find("Sphere5");//Sphere5のオブジェクトをunt5に代入
        GameObject unt6 = GameObject.Find("Sphere6");//Sphere6のオブジェクトをunt6に代入
        GameObject unt7 = GameObject.Find("Sphere7");//Sphere7のオブジェクトをunt7に代入

/*------------------------------------------------------------線をひく、消す-----------------------------------------------------------------*/
        /*Sphere1とSphere6をつなぐ線のカウントが1の時、線をひく*/
        if (c6 % 2 == 1)
        {
            var lineY56 = GameObject.Find("LineObject56").GetComponent<LineRenderer>();
            lineY56.enabled = true;
            lineY56.SetPosition(0, unt5.transform.position);
            lineY56.SetPosition(1, unt6.transform.position);
        }
        if(c6 % 2 == 0)
        {
            var lineY56 = GameObject.Find("LineObject56").GetComponent<LineRenderer>();
            lineY56.enabled = false;
        }
        /*Sphere1とSphere7をつなぐ線のカウントが1の時、線をひく*/
        if (c7 % 2 == 1)
        {
            var lineY57 = GameObject.Find("LineObject57").GetComponent<LineRenderer>();
            lineY57.enabled = true;
            lineY57.SetPosition(0, unt5.transform.position);
            lineY57.SetPosition(1, unt7.transform.position);
        }
        if(c7 % 2 == 0)
        {
            var lineY57 = GameObject.Find("LineObject57").GetComponent<LineRenderer>();
            lineY57.enabled = false;
        }

        if (Input.GetKey(KeyCode.R)){
          c6 = 0;//Sphere1とSphere6をつなぐ線のカウント
          c7 = 0;
          Debug.Log("Rキーを押した");
}
    }
    /*オブジェクト同士の衝突を判定*/
    void OnCollisionEnter(Collision collision)
    {
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
