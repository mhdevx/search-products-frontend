import axios from "axios";

export function search(term) {
    return axios({
        method: 'get',
        url: process.env.VUE_APP_SEARCH_PRODUCT_API + "/v1/search/" + term
    });
}
