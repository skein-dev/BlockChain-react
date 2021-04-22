import React, { Component } from 'react';

class ProductItem extends Component {

  render() {
    return (
        <tr>
            <th scope="row">{this.props.product.id.toString()}</th>
            <td>{this.props.product.name}</td>
            <td>{window.web3.utils.fromWei(this.props.product.price.toString(), 'Ether')} Eth</td>
            <td>{this.props.product.owner}</td>
            <td>
                { !this.props.product.purchased
                    ? <button
                        className="btn btn-primary purchase"
                        name={this.props.product.id}
                        value={this.props.product.price}
                        onClick={(event) => {
                        this.props.purchaseProduct(event.target.name, event.target.value)
                        }}
                    >
                        Buy
                    </button>
                    : null
                }
                { !this.props.product.purchased
                    ? <button
                        className="btn btn-primary delete"
                        name={this.props.product.id}
                        value={this.props.product.price}
                        onClick={(event) => {
                        this.props.deleteProduct(event.target.name, event.target.value)
                        }}
                    >
                        Delete
                    </button>
                    : null
                }
            </td>
        </tr>
    );
  }
}

export default ProductItem;
