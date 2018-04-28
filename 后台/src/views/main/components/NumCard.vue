<template>
<el-col :span="6">
    <div class="num-card">
        <div class="info-box">
            <el-col :span="9" class="center-y-f" :class="color">
                <i class="fa center-y-c" :class="iconType" aria-hidden="true"></i>
            </el-col>
            <el-col :span="15" class="center-y-f">
                <div class="num center-y-c">
                  <p>{{ number }}</p>
                  <span class="intro">
                    {{ intro }}
                  </span>
                </div>
            </el-col>
        </div>    
    </div>
</el-col>
</template>

<script>
function transformValue(val) {
  let endVal = 0;
  let unit = "";
  if (val < 1000) {
    endVal = val;
  } else if (val >= 1000 && val < 1000000) {
    endVal = parseInt(val / 1000);
    unit = "K+";
  } else if (val >= 1000000 && val < 10000000000) {
    endVal = parseInt(val / 1000000);
    unit = "M+";
  } else {
    endVal = parseInt(val / 1000000000);
    unit = "B+";
  }
  return {
    val: endVal,
    unit: unit
  };
}
export default {
  name: "NumCard",
  props: {
    endVal: Number,
    color: String,
    iconType: String,
    introText: String
  },
  computed: {
    number: function() {
      let res = transformValue(this.endVal);
      return res.val + res.unit;
    },
    intro: function() {
      return this.introText;
    }
  }
};
</script>

<style lang="less" scoped>
@100: 15vh;
.num-card {
  height: @100;
  background-color: #fff;
  -webkit-box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  border-radius: 4px;
  overflow: hidden;
  .info-box {
    width: 100%;
    height: @100;
    text-align: center;
    .el-col {
      height: @100;
      text-align: center;
      .fa {
        color: #fff;
        font-size: 2rem;
      }
      .num {
        width: 100%;
        p {
          font-size: 2rem;
          font-weight: 700;
        }
        .intro{
          color: #b8b8b8;
          font-size: 0.8rem;
        }
      }
    }
    .blue {
      background-color: rgb(59, 59, 231);
    }
  }
}
.color-grey {
  background: #eb9e05;
  color: #fff;
}

.color-blue {
  background: #2b6dfb;
  color: #fff;
}

.color-red {
  background: #e24361;
  color: #fff;
}

.color-green {
  background: #67c23a;
  color: #fff;
}
</style>

