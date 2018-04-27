using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class pos_ch : MonoBehaviour {

    int sc = 0;//Spaceを押した回数

    // Use this for initialization
    void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
        GameObject set1 = GameObject.Find("Set1");
        GameObject set2 = GameObject.Find("Set2");
        GameObject set3 = GameObject.Find("Set3");
        GameObject set4 = GameObject.Find("Set4");
        GameObject set5 = GameObject.Find("Set5");

        float set1x = set1.transform.position.x;
        float set1y = set1.transform.position.y;
        float set1z = set1.transform.position.z;

        float set2x = set2.transform.position.x;
        float set2y = set2.transform.position.y;
        float set2z = set2.transform.position.z;

        float set3x = set3.transform.position.x;
        float set3y = set3.transform.position.y;
        float set3z = set3.transform.position.z;

        float set4x = set4.transform.position.x;
        float set4y = set4.transform.position.y;
        float set4z = set4.transform.position.z;

        if (Input.GetKeyDown(KeyCode.Space))
        {
            sc++;//Spaceを押した回数をカウント
        }

        if (sc == 1)
        {
            set1.transform.position = new Vector3(set1x+4, set1y+3, set1z+4);
            sc++;
        }

        if (sc == 3)
        {
            set2.transform.position = new Vector3(set2x-2, set2y+4, set2z+3);
            sc++;
        }
       if(sc == 5)
        {
            set3.transform.position = new Vector3(set3x-2, set3y, set3z-2);
            sc++;
        }

       if (sc == 7)
        {
            set4.transform.position = new Vector3(set4x-1, set4y, set4z);
            sc++;
        }

    }
}
