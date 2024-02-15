import ScrollTo from 'stimulus-scroll-to'

export default class extends ScrollTo {
  connect() {
    super.connect()
    console.log('Do what you want here.')
  }

  get defaultOptions() {
    return {
      offset: 100,
      behavior: 'smooth',
    }
  }
}
