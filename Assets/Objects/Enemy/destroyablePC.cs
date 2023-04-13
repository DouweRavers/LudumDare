using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class destroyablePC : MonoBehaviour {
	public ParticleSystem explosion;
	public TextMeshPro textMesh;

	private int hitpoints = 6;

	public void GetHit() {
		hitpoints--;
		string lives = "";
		for (int i = 0; i < hitpoints; i++) {
			lives += "\u2665 ";
		};
		textMesh.text = lives;
		if (hitpoints <= 0) {
			Player.player.AddLive();
			StartCoroutine("Die");
		}
	}

	void Start() {
		textMesh.text = "".PadRight(hitpoints).Replace(" ", "\u2665");
	}

	void OnCollisionEnter(Collision collision) {
		foreach (ContactPoint contact in collision.contacts) {
			if (contact.otherCollider.gameObject.name.Equals("bullet")) GetHit();
		}
	}

	IEnumerator Die() {
		for (int i = 1; i < transform.childCount; i++) {
			transform.GetChild(i).gameObject.SetActive(false);
		}
		GetComponent<AudioSource>().Play();
		explosion.Play();
		yield return new WaitForSeconds(2f);
		Destroy(gameObject);
	}
}
