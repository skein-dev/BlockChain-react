import React, { Component } from 'react';
import ProductItem from './ProductItem';

class ProductList extends Component {

  render() {
    return (
        <table className="table">
          <thead>
            <tr>
              <th scope="col">#</th>
              <th scope="col">Name</th>
              <th scope="col">Price</th>
              <th scope="col">Owner</th>
              <th scope="col"></th>
            </tr>
          </thead>
          <tbody id="productList">
            { this.props.products.map((product, key) => {
                return(
                    <ProductItem
                        key={key}
                        product={product}
                        purchaseProduct={this.props.purchaseProduct}
                        deleteProduct={this.props.deleteProduct}
                    />
                )
            })}
          </tbody>
        </table>
    );
  }
}

export default ProductList;
