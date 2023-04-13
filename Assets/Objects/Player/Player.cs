using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Player : MonoBehaviour {
	public static Player player;
	public AudioSource metalHit;

	public int hitpoints = 10;
	void Start() {
		player = this;
	}

	public void GetHit() {
		hitpoints--;
		metalHit.Play();
		if (hitpoints <= 0) {
			SceneManager.LoadSceneAsync(1);
		}
	}

	public void AddLive() {
		if (hitpoints < 100)
			hitpoints += 10;
	}
}
