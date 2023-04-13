using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
public class DesertEnemy : MonoBehaviour {
	public Transform player, rotator;
	public LineRenderer laser;
	public ParticleSystem explosion;
	public TextMeshPro textMesh;

	private bool shooting = false;
	private int hitpoints = 3;

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

	void Update() {
		textMesh.transform.LookAt(Camera.main.transform);
		if (Vector3.Distance(player.position, transform.position) < 100) {
			rotator.LookAt(player);
			rotator.rotation = Quaternion.Euler(0, rotator.rotation.eulerAngles.y, 0);
			if (!shooting) {
				RaycastHit hit;
				Vector3 dir = player.position - laser.transform.position;
				if (Physics.Raycast(laser.transform.position, dir.normalized * 50, out hit, 120)) {
					if (hit.transform.CompareTag("Player"))
						StartCoroutine("ShootLaser", hit.point);
				}
			}
		}
	}

	IEnumerator ShootLaser(Vector3 hitpoint) {
		shooting = true;
		Vector3 target = laser.transform.InverseTransformPoint(hitpoint);
		laser.GetComponent<AudioSource>().Play();
		for (int i = 10; i > 0; i--) {
			laser.SetPosition(1, target / i);
			yield return new WaitForSeconds(0.01f);
		}
		Player.player.GetHit();
		yield return new WaitForSeconds(0.2f);
		laser.SetPosition(1, Vector3.zero);
		yield return new WaitForSeconds(Random.Range(1f, 3f));
		shooting = false;
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
