using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Endgame : MonoBehaviour {
	public Transform FinalAI;

	void OnTriggerEnter(Collider collision) {
		if (collision.gameObject.tag.Equals("Player")) {
			GetComponent<AudioSource>().Play();
		}
	}

	void Update() {
		if (FinalAI.childCount == 0) SceneManager.LoadSceneAsync(2);
	}
}
