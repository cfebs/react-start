import React from 'react';

class Main extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <div className="container">
                <h1>{this.props.title}</h1>
            </div>
        )
    }
}

export default Main;
