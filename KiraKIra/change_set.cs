using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class change_set : MonoBehaviour
{

    int sc = 0; //"Space"を押した回数

    // Use this for initialization
    void Start()
    {

        GameObject.Find("Set2").transform.Find("Star2").gameObject.SetActive(false);//set2を非表示化
        GameObject.Find("Set3").transform.Find("Star3").gameObject.SetActive(false);//set3を非表示化
        GameObject.Find("Set4").transform.Find("Star4").gameObject.SetActive(false);//set3を非表示化
        GameObject.Find("Set5").transform.Find("Star5").gameObject.SetActive(false);//set3を非表示化
    }

    // Update is called once per frame
    void Update()
    {
        


        GameObject set1 = GameObject.Find("Set1");//Set1のオブジェクトをset1に代入

        if (Input.GetKeyDown(KeyCode.Space))//"Space"を押すたびにカウントを1増やす
        {
            sc++;
        }

        if (sc == 1)//カウントが1の時set2を表示
        {
            GameObject.Find("Set2").transform.Find("Star2").gameObject.SetActive(true);//set2を表示
        }
        if (sc == 2)
        {
            GameObject.Find("Set3").transform.Find("Star3").gameObject.SetActive(true);//set3を表示
        }
        if (sc == 3)//カウントが1の時set2を表示
        {
            GameObject.Find("Set4").transform.Find("Star4").gameObject.SetActive(true);//set2を表示
        }
        if (sc == 4)
        {
            GameObject.Find("Set5").transform.Find("Star5").gameObject.SetActive(true);//set3を表示
        }
    }
}
