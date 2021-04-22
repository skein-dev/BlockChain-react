import React, { Component } from 'react';
import ProductList from './Product/ProductList';
import ProductAdd from './Product/ProductAdd';

class Main extends Component {
  constructor(props) {
    super(props)
  }
  render() {
    return (
      <div id="content">
        <h1>Add Product</h1>
        <ProductAdd
            createProduct={this.props.createProduct}
        />
        <p>&nbsp;</p>
        <h2>Buy Product</h2>
        <ProductList
            products={this.props.products}
            purchaseProduct={this.props.purchaseProduct}
            deleteProduct={this.props.deleteProduct}
        />
      </div>
    );
  }
}

export default Main;
