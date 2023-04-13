using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Cinemachine;

public class Gun : MonoBehaviour {
	public GameObject Ammo;
	public Transform gunTip, targetIndicator;
	public new ParticleSystem particleSystem;
	public LineRenderer line;

	private bool cooldown = false;

	void Update() {
		RaycastHit hit;
		Vector3 dir = gunTip.transform.forward;
		Debug.DrawRay(gunTip.transform.position, dir.normalized * 50);
		if (Physics.Raycast(gunTip.transform.position, dir.normalized * 50, out hit, Mathf.Infinity)) {
			targetIndicator.gameObject.SetActive(true);
			targetIndicator.position = hit.point;
			line.SetPosition(1, Vector3.forward * hit.distance);
			targetIndicator.localScale = Vector3.one * Mathf.Clamp(hit.distance * 0.2f, 2, 50);
			targetIndicator.GetChild(hit.transform.tag.Equals("Enemy") ? 0 : 1).gameObject.SetActive(true);
			targetIndicator.GetChild(hit.transform.tag.Equals("Enemy") ? 1 : 0).gameObject.SetActive(false);
		} else {
			targetIndicator.gameObject.SetActive(false);
		}
	}
	public void Shoot() {
		if (cooldown) return;
		cooldown = true;
		GameObject bullet = Instantiate(Ammo);
		bullet.transform.SetParent(transform.root);
		bullet.transform.position = gunTip.position;
		bullet.transform.rotation = gunTip.rotation;
		bullet.name = "bullet";
		bullet.GetComponent<Rigidbody>().velocity = transform.parent.GetComponent<Rigidbody>().velocity;
		bullet.GetComponent<Rigidbody>().AddForce(transform.forward * 100000);
		StartCoroutine("RemoveBullet", bullet);
		particleSystem.Play();
		GetComponent<AudioSource>().Play();

	}

	IEnumerator RemoveBullet(GameObject bullet) {
		yield return new WaitForSeconds(1f);
		Destroy(bullet);
		cooldown = false;
	}
}
