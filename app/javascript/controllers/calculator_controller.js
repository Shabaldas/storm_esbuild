import { Controller } from '@hotwired/stimulus';
import * as THREE from 'three'
import { STLLoader } from 'three/examples/jsm/loaders/STLLoader.js'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'

export default class extends Controller {
  static targets = [
    "scene", "name", "consumption", "size", "volume",
    "price", "form", "colorField", "sizeField", "weightField",
    "volumeField", "subtotalPriceField", "uploadContainer",
    "axesContainer"
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
    this.containerWidth = this.uploadContainerTarget.clientWidth
    this.containerHeight = this.uploadContainerTarget.clientHeight
    this.autoRotate = true
    this.grid = true
    this.objectHeigh = 0
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
    const price = Math.round(this.pricePerGram[this.material][this.quality] * this.consumption);
    this.priceTarget.innerText = "від ₴ " + price;
    this.subtotalPriceFieldTarget.setAttribute('value', price);
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
    const gridHelper = new THREE.GridHelper(200, 20)
    gridHelper.name = 'gridHelper';
    gridHelper.position.y = -this.objectHeigh/2;

    this.scene.add(gridHelper)
  }

  removeHelpers() {
    this.scene.remove(this.scene.getObjectByName('gridHelper'));
  }

  toggleAutorotate(e) {
    e.preventDefault()
    this.autoRotate = !this.autoRotate;
  }

  toggleGrid(e) {
    e.preventDefault();

    this.grid = !this.grid;

    if (this.grid) {
      this.setHelpers()
    } else {
      this.removeHelpers()
    }
  }

  toggleZoom(e) {
    e.preventDefault();

    const zoomType = e.params.zoomType;
    const fov = this.getFov();
    this.camera.fov = this.clickZoom(fov, zoomType);
    this.camera.updateProjectionMatrix();
  }

  getFov() {
    return Math.floor(
        (2 * Math.atan(this.camera.getFilmHeight() / 2 / this.camera.getFocalLength()) * 180) / Math.PI
    );
  };

  clickZoom(value, zoomType) {
    if (value >= 20 && zoomType === "zoomIn") {
      return value - 5;
    } else if (value <= 75 && zoomType === "zoomOut") {
      return value + 5;
    } else {
      return value;
    }
  };

  setCamera(x, y, z) {
    this.camera = new THREE.PerspectiveCamera(45, this.containerWidth / this.containerHeight, 0.1, 1000);
    this.camera.position.set(x, y, z)
  }

  setColor({ params: { color } }) {
    if (!this.stlObject) return

    this.colorFieldTarget.setAttribute('value', color);
    this.color = `0x${color}`
    this.stlObject.material.color.setHex(this.color)
  }

  setAxes() {
    this.axesScene = new THREE.Scene();
    this.axesScene.background = null;
    this.axesCamera = new THREE.PerspectiveCamera(45, this.containerWidth / this.containerHeight, 0.1, 1000);
    this.axesCamera.position.set(20, 20, 20)

    const axesHelper = new THREE.AxesHelper(1000);

    axesHelper.setColors(new THREE.Color(0xff0000), new THREE.Color(0x0000ff), new THREE.Color(0x00ff00))
    this.axesCamera.add(axesHelper);
  }

  onDropFile(event) {
    event.preventDefault();

    this.sceneTarget.innerHTML = ''
    this.axesContainerTarget.innerHTML = '';

    this.scene = new THREE.Scene();
    this.setAxes()

    const axesRenderer = new THREE.WebGLRenderer({ alpha: true })

    axesRenderer.setClearColor( 0x000000, 0 );
    axesRenderer.setSize(150, 150)

    this.scene.background = new THREE.Color(0xffffff)

    this.setCamera(20, 20, 20)

    this.setLight(50, 50, 50)
    this.setLight(-50, 50, -50)

    this.setAmbientLight()
    this.renderer = new THREE.WebGLRenderer()

    this.renderer.setSize(this.containerWidth, this.containerHeight)
    this.controls = new OrbitControls(this.camera, this.renderer.domElement);
    const axesControls = new OrbitControls(this.axesCamera, this.axesContainerTarget);

    const animate = () => {
      requestAnimationFrame(animate)
      axesControls.update()
      axesControls.autoRotate = this.autoRotate
      this.controls.update()
      this.controls.autoRotate = this.autoRotate
      this.axesScene.position.set(this.scene.position.x, this.scene.position.y, this.scene.position.z)
      this.axesCamera.position.set(this.camera.position.x, this.camera.position.y, this.camera.position.z)
      axesRenderer.render(this.axesScene, this.axesCamera)
      this.renderer.render(this.scene, this.camera);
    }

    this.axesContainerTarget.appendChild(axesRenderer.domElement)
    this.sceneTarget.appendChild(this.renderer.domElement)
    animate()

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
      this.objectHeigh = z

      if (x > 180 || x < 5 || y > 180 || y < 5 || z > 180 || z < 5) {
        alert('Error: Loaded model sizes must be between 1 sm and 18 sm')
        event.target.value = null
        this.resetToDefaults()
        return
      }

      const material = new THREE.MeshStandardMaterial({ color: parseInt(this.color) })
      const volume = this.getVolume(geometry)
      const newPosition = Math.max(x, y, z)
      const size = `${(x / 10).toFixed(2)} x ${(y / 10).toFixed(2)} x ${(z / 10).toFixed(2)}`
      const volumeValue = (volume / 1000).toFixed(2)

      this.volumeTarget.innerText = volumeValue;
      this.nameTarget.innerText = stlFile.name;
      this.volumeFieldTarget.setAttribute('value', volumeValue);

      this.consumption = volume * this.consumptionPerCubicGram

      const weight = this.consumption.toFixed(1)
      this.consumptionTarget.innerText = weight;
      this.weightFieldTarget.setAttribute('value', weight);

      this.sizeTarget.innerText = size
      this.sizeFieldTarget.setAttribute('value', size);

      this.calculatePrice()
      this.stlObject = new THREE.Mesh(geometry, material)
      this.camera.position.set(newPosition, newPosition, newPosition)
      this.stlObject.rotateX(-Math.PI / 2)
      this.stlObject.name = 'currentObject'
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

  submitForm() {
    this.formTarget.requestSubmit();
  }
}
