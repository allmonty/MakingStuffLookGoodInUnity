using UnityEngine;
using System.Collections;

public class ParticleRotate : MonoBehaviour {

    public float angleSpeed;

	void Update () {
        transform.Rotate(Vector3.forward, angleSpeed * Time.deltaTime);
	}
}
