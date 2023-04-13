using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Cinemachine;
public class AimController : MonoBehaviour {
	public CinemachineVirtualCamera playerCamera;
	public Gun cannon;
	public Transform gunTransform, target;

	public float mouseYDelta = 10;

	void Start() {
		Cursor.visible = false;
		Cursor.lockState = CursorLockMode.Locked;
	}

	void Update() {
		Vector3 new_offset = playerCamera.GetCinemachineComponent<CinemachineTransposer>().m_FollowOffset;
		new_offset += Vector3.up * Input.GetAxis("Mouse Y") * Time.deltaTime * mouseYDelta * -1f;
		if (new_offset.y > 0.5f && new_offset.y < 13)
			playerCamera.GetCinemachineComponent<CinemachineTransposer>().m_FollowOffset = new_offset;
		gunTransform.LookAt(target);
		if (Input.GetMouseButtonDown(0)) cannon.Shoot();
	}
}
