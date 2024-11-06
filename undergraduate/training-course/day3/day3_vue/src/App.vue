<template>
  <div>
    <h1>{{ name }}</h1>
    <h2 v-html="msg"></h2>

    <div v-if="sex == 1">性别：男
    </div>
    <div v-else-if="sex == 2">性别：女
    </div>
    <div v-else>
      <h1>world</h1>
    </div>
    <div @click="change">
      点击
    </div>

    <button @click="countSub">
      -
    </button>
    <span>
      {{ count }}
    </span>
    <button @click="countAdd">
      +
    </button>

    <div>
      <button @click="buy(5)">快乐水5￥</button>
      <button @click="buy(40)">黑色毒药40￥</button>
      <button @click="buy(0)">益生菌0￥</button>
      <button @click="buy(-20)">找文清借钱</button>
      <span>余额：{{ price }}</span>
    </div>

    <div class="box">
      <h3>自动售货机</h3>
      <button @click="buy(5)">可乐5元</button>
      <button @click="buy(10)">咖啡10元</button>
      <button @click="buy(8)">牛奶8元</button>
    </div>
    <p>银行卡余额:{{ price }}元</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      name: 'App',
      msg: `<p>123545645<p>`,
      sex: 1,
      count: 0,
      price: 1000
    }
  },
  methods: {
    change() {
      this.name = 'hello'
      console.log('this');
    },
    countAdd() {
      this.count++
    },
    countSub() {
      this.count--
    },
    buy(money) {
      if (this.price >= money) {
        this.price -= money
      } else {
        alert('余额不足')
      }
    }
  }
}
</script>

<style>
.box {
  border: 3px solid #000000;
  border-radius: 10px;
  padding: 20px;
  margin: 20px;
  width: 200px;
}
h3 {
  margin: 10px 0 20px 0;
}
p {
  margin: 20px;
}
</style>
