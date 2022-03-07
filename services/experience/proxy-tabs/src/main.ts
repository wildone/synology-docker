import { createApp } from 'vue'
import App from './App.vue'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faUserSecret } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { faSpinner, faArrowRight, faArrowLeft , faRotateLeft, faHouse, faBars, faBookmark, faStar, faExpand } from '@fortawesome/free-solid-svg-icons'

// import { fas } from '@fortawesome/free-solid-svg-icons'
// import { far } from '@fortawesome/free-regular-svg-icons'
// import { fab } from '@fortawesome/free-brands-svg-icons'

library.add(faUserSecret)
// chrome tabs
library.add(faSpinner, faArrowRight, faArrowLeft, faRotateLeft, faHouse, faBars, faBookmark, faStar, faExpand)

createApp(App)
.component('font-awesome-icon', FontAwesomeIcon)
.mount('#app')
