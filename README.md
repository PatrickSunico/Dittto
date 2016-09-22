# Dittto WIP

## Use Case
Dittto, Is a design portfolio sharing app where users can view other users design work for projects, They can like and post comments to critique on works done by a user. To be specific It is a Dribbble clone application that is built from the ground up with Rails, Javascript, HTML and CSS.

## Specs

* Dittto manages image uploads and image processing on the fly via the cloudinary gem inside heroku, While the uploading functionality is being handle by the carrierwave gem.

* Dittto uses carrierwave_backgrounder with sidekiq to handle the background process of uploading, as well as reducing the chance of a request timeout. Since heroku has a 30 second timeout rule, which is bad for production.

* In production tests, Dittto has a single dyno worker reserved for the image upload process.

* Dittto uses [dropzone-js](http://www.dropzonejs.com/) by enyo, Which allows mass file uploads with DnD functionality. With this mass file uploads are uploaded directly from the Cloudinary storage, while the server stores the appended url or the file destination of the image upload. i.e https://res-3.cloudinary.com/ditto/image/upload/

* The debate between S3 or Cloudinary has been thoroughly planned,
  * S3 Route
    * Removes the factor of image processing on the fly, But instead uses rmagick or minimagick gem to process the file uploads i.e small-medium size images from
      the original uploaded file.
    * Documentation support or knowledgable resources were insufficient during the planning phase.
  * Cloudinary Route
    * Enables Image Processing on the fly as per the documentation says in the cloudinary rails-docs.
    * Abundant Documentation Support, from cloudinary docs and from heroku Ruby on Rails docs.
    * Since Images are the only ones that are being handled, Cloudinary suits Dittto's needs

# Todo

Current Progress: 60% Complete
- Back-end Tasks
	- [x] Data Associations
	- [x] Restful Routes with nested resources
	- [x] Implement Friendly_id for each unique user
	- [x] Refactor Database Migrations
	- [x] Dropzone-js Implementation
	- [x] Configure Cloudinary to Rails Server for image uploads
	- [x] Basic Rspec Testing
- Front-end Tasks
	- [ ] Some basic Styling for testing purposes in Heroku (On-going)
	- [ ] Fix some whitespace Errors in the view
