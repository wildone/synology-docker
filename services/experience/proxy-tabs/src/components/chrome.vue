<template>
  <div>
    <div class="chrome-ui" ref="content">
      <vue3-tabs-chrome :ref="setTabRef" :tabs="tabs" v-model="tab">
        <template v-slot:after>
          <button
            class="btn"
            style="
              height: 20px;
              line-height: 20px;
              padding: 0 10px;
              margin-left: 0px;
            "
            @click="handleAdd"
          >
            +
          </button>
        </template>
      </vue3-tabs-chrome>
      <div class="nav">
        <div class="nav-btns">
          <span class="nav-btn disabled" @click="handleNavClick('back')">
            <font-awesome-icon icon="arrow-left" />
          </span>
          <span class="nav-btn disabled" @click="handleNavClick('forward')">
            <font-awesome-icon icon="arrow-right" />
          </span>
          <span class="nav-btn disabled" @click="handleNavClick('refresh')">
            <font-awesome-icon icon="rotate-left" />
          </span>
          <span class="nav-btn disabled" @click="handleNavClick('home')">
            <font-awesome-icon icon="house" />
          </span>
        </div>
        <div class="nav-location">
          <input type="search" ref="location" class="nav-location-input" v-model="location" @keydown.enter="handleSearch">
          <span class="nav-btn nav-collection disabled" @click="handleCollection">
            <font-awesome-icon icon="bookmark" />
          </span>
        </div>
        <div class="nav-btns">
          <span class="nav-btn" @click="handleFullscreen">
            <font-awesome-icon icon="expand" />
          </span>
          <span class="nav-btn disabled" @click="handleMore">
            <font-awesome-icon icon="bars" />
          </span>
        </div>
      </div>
      <iframe :src="url" frameborder="0"></iframe>
    </div>
  </div>
</template>

<script lang="ts">
import Vue3TabsChrome from "vue3-tabs-chrome";
import { defineComponent, reactive, ref } from "vue";
import "vue3-tabs-chrome/dist/vue3-tabs-chrome.css";

export default defineComponent({
  components: {
    Vue3TabsChrome,
  },
  setup() {
    const tabRef = ref();
    const tab = ref("google");
    const tabs = reactive([
      {
        label: "google",
        key: "google",
        url: "https://google.com",
        favico: "https://www.google.com/favicon.ico",
      },
      {
        label: "bing",
        key: "bing",
        url: "https://bing.com",
        favico: "https://bing.com/favicon.ico",
      },
      {
        label: "myip",
        key: "myip",
        url: "https://www.myip.com/",
        favico: "https://www.myip.com/favicon.ico",
      },
      // {
      //   label: "New Tab",
      //   key: "costom key",
      //   url: "about:blank",
      // },
    ]);
    const setTabRef = (el) => {
      tabRef.value = el;
    };

    const handleAdd = () => {
      const key = "tab" + Date.now();
      tabRef.value.addTab({
        label: "New Tab",
        key,
        url: "about:blank",
      });

      tab.value = key;
    };

    const handleRemove = () => {
      tabRef.value.removeTab(tab.value);
    };
    return {
      tabs,
      tab,
      handleAdd,
      handleRemove,
      setTabRef,
    };
  },
  mounted () {
    this.tab = 'myip'
  },
  computed: {
    url () {
      let currTab = this.tabs.find(item => item.key === this.tab)
      let url = ''
      if (currTab) {
        url = currTab.url || ''
      }

      if (url === '') {
        return url
      }
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://' + url
      }

      console.log("URL:"+url);

      let prefix = '/sw/'
      let proxyPort = 8844
      let hostName = window.location.hostname
      let proxyUrl = this.urlEncode(url)
      let proxyUrlD = this.urlDecode(proxyUrl)
      let proxyUrlFull = "https://"+hostName+":"+proxyPort+prefix+proxyUrl
      console.log("PROXY: "+proxyUrlFull)
      console.log("PROXY E: "+proxyUrl)
      console.log("PROXY D: "+proxyUrlD)

      return proxyUrlFull
    }
  },
  watch: {
    tab () {
      let tab = this.getCurrTab()
      let location = tab.url || ''

      if (!location) {
        return ''
      }

      if (!location.startsWith('http://') && !location.startsWith('https://')) {
        location = 'https://' + location
      }

      this.location = location
    }
  },
  methods: {
    addTab () {
      let item = 'tab' + Date.now()
      let newTabs = [
        {
          label: 'New Tab',
          key: item
        }
      ]
      this.$refs.tab.addTab(...newTabs)
      this.tab = item
      this.location = ''
    },
    removeTab () {
      this.$refs.tab.removeTab(this.tab)
    },
    handleClick (e, tab, i) {
      console.log(e, tab, i)
    },
    handleSearch () {
      let { location } = this
      let label = (location.split('.').slice(-2)[0]).toUpperCase()
      let favicon = ''
      if (location.includes('.')) {
        if (!location.startsWith('http://') && !location.startsWith('https://')) {
          location = 'https://' + location
        }
      } else {
        location = `https://www.bing.com/search?q=${encodeURIComponent(location)}`
        label = 'Bing'
        favicon = 'https://bing.com/favicon.ico'
      }

      if (!favicon) {
        favicon = location + '/favicon.ico'
      }

      let tab = this.getCurrTab()
      tab.label = label
      tab.url = location
      tab.favicon = favicon

      // this.tab = key
      this.$refs.location.blur()

      this.tabs.splice()
    },
    getCurrTab () {
      return this.tabs.find(item => item.key === this.tab)
    },
    handleNavClick (msg) {
      console.log(msg)
    },
    handleCollection () {
      console.log('collection')
    },
    handleMore () {
      console.log('menu')
    },
    handleFullscreen () {
      this.$refs.content.requestFullscreen()
    },
    urlEncode (str: { toString: () => string; }) {
      return encodeURIComponent(
            str
              .toString()
              .split("")
              .map((char, ind) =>
                ind % 2 ? String.fromCharCode(char.charCodeAt() ^ 2) : char
              )
              .join("")
          );
    },
    urlDecode (str: { toString: () => string; }) {
      if (str.toString().charAt(str.toString().length - 1) == "/") str = str.toString().slice(0, -1);
      return decodeURIComponent(str.toString())
        .split("")
        .map((char, ind) =>
          ind % 2 ? String.fromCharCode(char.charCodeAt() ^ 2) : char
        )
        .join("");
    },
  }
});
</script>

<style>
.btn {
  border: 1px solid #f06;
  padding: 10px 16px;
  border-radius: 2px;
  border: 1px solid #fff;
  box-shadow: 0 3px 1px -2px rgba(0, 0, 0, 0.2), 0 2px 2px 0 rgba(0, 0, 0, 0.14),
    0 1px 5px 0 rgba(0, 0, 0, 0.12);
  background-color: #fff;
  user-select: none;
  cursor: pointer;
}

.btn + .btn {
  margin-left: 30px;
}

.btns {
  padding: 50px 30px;
}
</style>


<style lang="less">
.chrome-ui {
  box-shadow: 2px 2px 5px #ddd;

  input[type=search]::-webkit-search-cancel-button{
    -webkit-appearance: none;
  }

  .btn-add {
    width: 28px;
    height: 28px;
    border-radius: 50%;
    padding: 0 10px;
    color: #333;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
    transition: background 300ms;

    &:hover {
      background-color: rgba(0, 0, 0, .1);
    }
  }

  .disabled {
    cursor: not-allowed !important;
  }

  .nav {
    padding: 8px;
    background-color: #fff;
    border-bottom: 1px solid #d5d7db;
    display: flex;
    align-items: center;
    position: relative;
  }

  .nav-btns {
    display: flex;
  }

  .nav-btn {
    width: 28px;
    height: 28px;
    margin-left: 4px;
    border-radius: 14px;
    color: #666;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 300ms;
    cursor: pointer;

    &:first-of-type {
      margin-left: 0;
    }

    &:hover {
      background-color: rgba(0, 0, 0, .1);
    }
  }

  .nav-location {
    flex: 1;
    height: 28px;
    margin: 0 8px;
    position: relative;
  }

  .nav-location-input {
    width: 100%;
    height: 100%;
    border: none;
    background-color: #eff1f2;
    border-radius: 14px;
    outline: none;
    padding-left: 16px;
    transition: background 300ms;

    &:hover {
      background-color: #e6e8e9;
    }

    &:focus {
      box-shadow: 0 0 0 3px Highlight;
      background-color: #fff;
    }
  }

  .nav-collection {
    top: 50%;
    right: 2px;
    width: 32px;
    height: 24px;
    border-radius: 12px;
    position: absolute;
    transform: translateY(-50%);
  }

  iframe {
    width: 100%;
    min-height: calc(100vh - 90px);
    background-color: #f4f4f4;
  }
}
</style>
