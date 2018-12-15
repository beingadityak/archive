import React, {Component} from 'react';

class Gallery extends Component{

	render(){

		let alternate = "http://www.shipelectric.com/sites/default/files/default_images/notFound_1_0.png";

		return(
			<div>
			{
				this.props.items.map((item,index) => {
					let {title, imageLinks, infoLink} = item.volumeInfo;
					return(

						<a key={index}
						   href={infoLink}
						   target="_blank"
						   className = "book">
							<img 
							src = {imageLinks !== undefined ? imageLinks.thumbnail:alternate} 
							alt="Books Image"
							className="book-img"/>
							<div className="book-text">
								{title}
							</div>
							
						</a>
						);
				})
			}
			</div>
			);
	}

}

export default Gallery;