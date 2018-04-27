using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class collision2 : MonoBehaviour
{
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
        GameObject unt2 = GameObject.Find("Sphere2");//Sphere2のオブジェクトをunt2に代入
        GameObject unt3 = GameObject.Find("Sphere3");//Sphere3のオブジェクトをunt3に代入
        GameObject unt4 = GameObject.Find("Sphere4");//Sphere4のオブジェクトをunt4に代入
        GameObject unt5 = GameObject.Find("Sphere5");//Sphere5のオブジェクトをunt5に代入
        GameObject unt6 = GameObject.Find("Sphere6");//Sphere6のオブジェクトをunt6に代入
        GameObject unt7 = GameObject.Find("Sphere7");//Sphere7のオブジェクトをunt7に代入

        /*------------------------------------------------------------線をひく、消す-----------------------------------------------------------------*/
        /*Sphere1とSphere３をつなぐ線のカウントが1の時線をひき、0のとき線を消す*/
        if (c3 % 2 == 1)
        {
            var lineY23 = GameObject.Find("LineObject23").GetComponent<LineRenderer>();
            lineY23.enabled = true;
            lineY23.SetPosition(0, unt2.transform.position);
            lineY23.SetPosition(1, unt3.transform.position);
        }

        if (c3 % 2 == 0)
        {
            var lineY23 = GameObject.Find("LineObject23").GetComponent<LineRenderer>();
            lineY23.enabled = false;
        }
        /*Sphere1とSphere4をつなぐ線のカウントが1の時、線をひく*/
        if (c4 % 2 == 1)
        {
            var lineY24 = GameObject.Find("LineObject24").GetComponent<LineRenderer>();
            lineY24.enabled = true;
            lineY24.SetPosition(0, unt2.transform.position);
            lineY24.SetPosition(1, unt4.transform.position);
        }
        if (c4 % 2 == 0)
        {
            var lineY24 = GameObject.Find("LineObject24").GetComponent<LineRenderer>();
            lineY24.enabled = false;
        }
        /*Sphere1とSphere5をつなぐ線のカウントが1の時、線をひく*/
        if (c5 % 2 == 1)
        {
            var lineY25 = GameObject.Find("LineObject25").GetComponent<LineRenderer>();
            lineY25.enabled = true;
            lineY25.SetPosition(0, unt2.transform.position);
            lineY25.SetPosition(1, unt5.transform.position);
        }
        if (c5 % 2 == 0)
        {
            var lineY25 = GameObject.Find("LineObject25").GetComponent<LineRenderer>();
            lineY25.enabled = false;
        }
        /*Sphere1とSphere6をつなぐ線のカウントが1の時、線をひく*/
        if (c6 % 2 == 1)
        {
            var lineY26 = GameObject.Find("LineObject26").GetComponent<LineRenderer>();
            lineY26.enabled = true;
            lineY26.SetPosition(0, unt2.transform.position);
            lineY26.SetPosition(1, unt6.transform.position);
        }
        if (c6 % 2 == 0)
        {
            var lineY26 = GameObject.Find("LineObject26").GetComponent<LineRenderer>();
            lineY26.enabled = false;
        }
        /*Sphere1とSphere7をつなぐ線のカウントが1の時、線をひく*/
        if (c7 % 2 == 1)
        {
            var lineY27 = GameObject.Find("LineObject27").GetComponent<LineRenderer>();
            lineY27.enabled = true;
            lineY27.SetPosition(0, unt2.transform.position);
            lineY27.SetPosition(1, unt7.transform.position);
        }
        if (c7 % 2 == 0)
        {
            var lineY27 = GameObject.Find("LineObject27").GetComponent<LineRenderer>();
            lineY27.enabled = false;
        }

        if (Input.GetKey(KeyCode.R))
        {
            c3 = 0;//Sphere1とSphere3をつなぐ線のカウント
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
