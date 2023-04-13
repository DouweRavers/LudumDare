using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;
using UnityEngine.Events;

public class VideoFix : MonoBehaviour {
	public VideoPlayer videoPlayer;
	public GameObject message;
	public string movie;

	void Start() {
		videoPlayer.url = System.IO.Path.Combine(Application.streamingAssetsPath, movie);
		videoPlayer.Play();
		videoPlayer.started += DeleteMessage;
		Cursor.visible = true;
		Cursor.lockState = CursorLockMode.Confined;
	}


	void DeleteMessage(UnityEngine.Video.VideoPlayer vp) {
		message.SetActive(false);
	}
}
