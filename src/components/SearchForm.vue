<template>
  <div class="container" >
      <header>
 <div class="row">
<nav class="navbar navbar-dark bg-primary navbar-expand-md fixed-top">
  <form class="form-inline" v-on:submit.prevent="showTermAndSearch(term)">
    <input  class="form-control mr-sm-2 p-2 bd-highlight" type="search" 
    placeholder="¿Qué está buscando?" aria-label="Search" v-model="term" >
    <a v-on:click="showTermAndSearch(term)" class="btn btn-outline-light my-2 my-sm-0"> 
        <font-awesome-icon :icon="['fas', 'search']"/>.
    </a>
  </form>
</nav>
</div>
</header>
    <div class="row">
        <p v-if="loading!==true && termAux.length>0" style="text-align: center;">
            Resultados para: {{ termAux }}
            </p>
        <h4 v-if="loading===true">{{ messageResponse }}</h4>
    </div>
    <div class="row">
        
      <div class="col-md-3 col-lg-offset-4" v-for="(product, i) in products" :key="i">
          
        <div class="card mb-4 box-shadow" style="width: 250px;">
          <img
            width="1"
            class="card-img-top"
            :src="'https://' + product.image"
            alt=""
          />
          <div class="card-body">
            <div class="d-flex text-left product-description  ">
              <div>
                <span
                  class=""
                  style="font-weight: bold; color: rgb(0, 0, 0);"
                  >{{ product.brand }}</span
                ><span> {{ product.description }} </span>
              </div>
            </div>

            <div class="d-flex" style="display: flex; align-items: center;">
              $ {{ product.price }}
              <div v-if="product.discountApplied>0"
                class="walmart-discount-percentage-card"
                style="margin-top: 1px; margin-left: 6px;"
              >
                {{ product.discountApplied * 100 }}%
              </div>
            </div>
            <div v-if="product.discountApplied>0" class="d-flex">
              <span class="walmart-reference-price"
                >$ {{ product.priceOld }}</span
              >
            </div>
            <div class="align-center">
              <button
                type="button"
                class="my-2 btn btn-primary"
                style="display: flex; align-items: center;"
              >
                Agregar
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { search } from "../services/search";
import { library } from "@fortawesome/fontawesome-svg-core";
import {
  faSearch
} from "@fortawesome/free-solid-svg-icons";
library.add(faSearch);

export default {
  name: "SearchForm",
  props: {
    msg: String,
  },
  data() {
    return {
      term: null,
      products: null,
      errorResponse: null,
      termAux: "",
      loading:false,
      messageResponse:""
    };
  },
  methods: {
    search(term) {
        this.loading=true;
        this.messageResponse="La aplicación está obteniendo los datos, por favor espere..."
      search(term)
        .then((response) => (this.products = response.data))
        .then(()=>{
            this.loading=false;
        })
        .catch((error) => (this.errorResonse = error));
        
    },
    showTermAndSearch(term){
        if(term.length>0){
            this.termAux = term;
        this.search(term)
        this.term = ""
        }
        
    }
  },
  mounted() {
    this.search("asd");
  },
};
</script>
<style scoped src="../../node_modules/bootstrap/dist/css/bootstrap.css"></style>
<style scoped>
.ais-SearchBox-input {
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  padding: 0.3rem 2.2rem;
  width: 80%;
  position: relative;
  background-color: #fff;
  border: 1px solid #c4c8d8;
  border-radius: 5px;
}

.ais-SearchBox-input::-webkit-input-placeholder {
  color: #a5aed1;
}
.ais-SearchBox-input::-moz-placeholder {
  color: #a5aed1;
}
.ais-SearchBox-input:-ms-input-placeholder {
  color: #a5aed1;
}
.ais-SearchBox-input:-moz-placeholder {
  color: #a5aed1;
}
.ais-SearchBox-form{display:block;position:relative}
</style>
