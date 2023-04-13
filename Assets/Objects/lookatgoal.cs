using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class lookatgoal : MonoBehaviour {

	public Transform goal;
	void Update() {
		transform.LookAt(goal);
	}
}
