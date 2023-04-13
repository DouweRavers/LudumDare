using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class PlayerUI : MonoBehaviour {
	public TextMeshProUGUI Lives, speed;
	public GameObject infoPanel;

	void Update() {
		speed.text = Mathf.RoundToInt(Player.player.GetComponent<Rigidbody>().velocity.magnitude * 3.6f) + "Km/h";
		Lives.text = "".PadLeft(Mathf.RoundToInt(Player.player.hitpoints / 5)).Replace(" ", "\u2665");
		if (Input.GetMouseButtonDown(1)) infoPanel.SetActive(!infoPanel.activeSelf);
	}
}
