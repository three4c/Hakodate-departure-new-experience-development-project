using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class collision6 : MonoBehaviour
{
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
        GameObject unt6 = GameObject.Find("Sphere6");//Sphere6のオブジェクトをunt6に代入
        GameObject unt7 = GameObject.Find("Sphere7");//Sphere7のオブジェクトをunt7に代入

/*------------------------------------------------------------線をひく、消す-----------------------------------------------------------------*/
        /*Sphere1とSphere7をつなぐ線のカウントが1の時、線をひく*/
        if (c7 % 2 == 1)
        {
            var lineY67 = GameObject.Find("LineObject67").GetComponent<LineRenderer>();
            lineY67.enabled = true;
            lineY67.SetPosition(0, unt6.transform.position);
            lineY67.SetPosition(1, unt7.transform.position);
        }
        if(c7 % 2 == 0)
        {
            var lineY67 = GameObject.Find("LineObject67").GetComponent<LineRenderer>();
            lineY67.enabled = false;
        }

        if (Input.GetKey(KeyCode.R)){
          c7 = 0;//Sphere6とSphere7をつなぐ線のカウント
          Debug.Log("Rキーを押した");
}
    }
    /*オブジェクト同士の衝突を判定*/
    void OnCollisionEnter(Collision collision)
    {
        /*Sphere1とSphere7が衝突したらカウント*/
        if (collision.gameObject.name == "Sphere7")
        {
            c7 += 1;
            audioSouse.Play();
        }
      }
}
