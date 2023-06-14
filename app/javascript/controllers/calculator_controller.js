import { Controller } from '@hotwired/stimulus';
import * as THREE from 'three'
import { STLLoader } from 'three/examples/jsm/loaders/STLLoader.js'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'

export default class extends Controller {
  static targets = [
    "scene", "name", "consumption", "size", "volume",
    "price"
  ]

  initialize() {
    this.stlObject = null
    this.color = 0xDDDDDD
    this.consumption = 0
    this.consumptionPerCubicGram = 0.00125
    this.material = null
    this.quality = null
    this.pricePerGram = {
      pla: { 100: 5, 200: 4, 300: 3.5 },
      abs: { 100: 5, 200: 4, 300: 3.5 },
      pet: { 100: 4.5, 200: 4, 300: 3.5 },
      nylon: { 100: 10, 200: 8, 300: 7 },
      elastan: { 100: 10, 200: 8, 300: 7 }
    }
  }

  setMaterial({ target: { value } }) {
    this.material = value

    if (this.consumption > 0 && this.quality) {
      this.calculatePrice()
    }
  }

  setQuality({ target: { value }}) {
    this.quality = value

    if (this.consumption > 0 && this.material) {
      this.calculatePrice()
    }
  }

  calculatePrice() {
    if (!this.material || !this.quality) return

    this.priceTarget.innerText = Math.round(this.pricePerGram[this.material][this.quality] * this.consumption)
  }

  connect() {
    this.scene = new THREE.Scene();
    this.scene.background = new THREE.Color({ color: 0xDEE0E2 })

    this.setCamera(20, 20, 20)

    this.setLight(50, 50, 50)
    this.setLight(-50, 50, -50)

    this.setAmbientLight()

    this.renderer = new THREE.WebGLRenderer()
    this.renderer.setSize(window.innerWidth / 2, window.innerHeight / 2)
    this.controls = new OrbitControls(this.camera, this.renderer.domElement);

    const animate = () => {
      requestAnimationFrame(animate)

      this.controls.update()
      this.controls.autoRotate = true

      this.renderer.render(this.scene, this.camera);
    }

    this.sceneTarget.appendChild(this.renderer.domElement)
    animate()
  }

  setLight(x, y, z) {
    const pointLight = new THREE.PointLight(0xFFFFFF)
    pointLight.position.set(x, y, z)
    this.scene.add(pointLight)
  }

  setAmbientLight() {
    const light = new THREE.AmbientLight(0x404040, 0.3)
    this.scene.add(light)
  }

  setHelpers() {
    const axesHelper = new THREE.AxesHelper(50);
    axesHelper.setColors(new THREE.Color(0xff0000), new THREE.Color(0x0000ff), new THREE.Color(0x00ff00))
    this.scene.add(axesHelper);

    const gridHelper = new THREE.GridHelper(200, 200)
    this.scene.add(gridHelper)
  }

  setCamera(x, y, z) {
    this.camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 0.1, 1000);
    this.camera.position.set(x, y, z)
  }

  setColor({ params: { color } }) {
    if (!this.stlObject) return

    this.color = `0x${color}`
    this.stlObject.material.color.setHex(this.color)
  }

  onDropFile(event) {
    const stlFile = event.target.files[0]
    const reader = new FileReader()
    this.scene.remove(this.stlObject)
    reader.addEventListener('load', (e) => {
      const contents = e.target.result
      const geometry = new STLLoader().parse(contents)

      geometry.center()
      geometry.computeBoundingBox()
      const box = geometry.boundingBox

      const x = box.max.x + Math.abs(box.min.x)
      const y = box.max.y + Math.abs(box.min.y)
      const z = box.max.z + Math.abs(box.min.z)

      if (x > 180 || x < 10 || y > 180 || y < 10 || z > 180 || z < 10) {
        alert('Error: Loaded model sizes must be between 1 sm and 18 sm')
        event.target.value = null
        this.resetToDefaults()
        return
      }

      const material = new THREE.MeshStandardMaterial({ color: parseInt(this.color) })
      const volume = this.getVolume(geometry)
      const newPosition = Math.max(x, y, z)

      this.volumeTarget.innerText = (volume / 1000).toFixed(2)
      this.consumption = volume * this.consumptionPerCubicGram
      this.consumptionTarget.innerText = this.consumption.toFixed(1)
      this.sizeTarget.innerText = `${(x / 10).toFixed(2)} x ${(y / 10).toFixed(2)} x ${(z / 10).toFixed(2)}`

      this.calculatePrice()
      this.stlObject = new THREE.Mesh(geometry, material)
      this.camera.position.set(newPosition, newPosition, newPosition)
      this.stlObject.rotateX(-Math.PI / 2)
      this.scene.add(this.stlObject)
    }, false);
    if (reader.readAsBinaryString !== undefined) {
      reader.readAsBinaryString(stlFile)
    } else {
      reader.readAsArrayBuffer(stlFile)
    }
  }

  getVolume(geometry) {
    let position = geometry.attributes.position
    let faces = position.count / 3
    let sum = 0
    let p1 = new THREE.Vector3(), p2 = new THREE.Vector3(), p3 = new THREE.Vector3()

    for (let i = 0; i < faces; i++) {
      p1.fromBufferAttribute(position, i * 3 + 0)
      p2.fromBufferAttribute(position, i * 3 + 1)
      p3.fromBufferAttribute(position, i * 3 + 2)
      sum += this.signedVolumeOfTriangle(p1, p2, p3)
    }
    return sum
  }

  signedVolumeOfTriangle(p1, p2, p3) {
    return p1.dot(p2.cross(p3)) / 6.0
  }

  resetToDefaults() {
    this.volumeTarget.innerText = 0
    this.consumptionTarget.innerText = 0
    this.sizeTarget.innerText = '0 x 0 x 0'
    this.priceTarget.innerText = 0
  }
}