using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class LoadGame : MonoBehaviour {
	public Slider slider;
	private AsyncOperation loadingOperation;

	public void OnPlay() {
		loadingOperation = SceneManager.LoadSceneAsync(1);
		slider.gameObject.SetActive(true);
	}

	void Update() {
		if (slider.gameObject.activeSelf) {
			slider.value = loadingOperation.progress;
		}

	}
}
