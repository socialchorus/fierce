# Fierce

Fierce is opinionate view logic for Rails. Templates are written in HTML and tucked into the views directory. View logic is handled by presenters, that have their own top level app directory. These presenters are plain old Ruby objects, not some special subclass of Fierceness. 

![Fierce Conchita Wurst](http://eurovisionireland.files.wordpress.com/2013/10/conchita-wurst-internal-selection.jpg)
###### Fierce image brought to you by Conchita Wurst: http://eurovisionireland.files.wordpress.com/2013/10/conchita-wurst-internal-selection.jpg.

## Installation

Add this line to your application's Gemfile:

    gem 'fierce'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fierce

## Usage

Install the gem and you will be ready to start writing mustache templates. These templates get tucked into the appropriate place in your views directory, just like an ERB or HAML view. As with other view pre-processors, the file name usually includes the ultimate format, for example: show.html.mustache. 

When Rails goes to find the view logic to marry with the mustache, it will look the presenters directory. So, go make a presenters directory! 

  `mkdir app/presenters`

If there a presenter is not found, the mustache gets rendered from the logic it can find. 

Given a mustache template like this:

    <h1>Be Fierce</h1>
    <p>{{from_instance_variables}}</p>
    <p>{{from_helpers}}</p>
    <p>{{from_your_presenter}}</p>

And a controller that exposes an instance variable like so:

    # some controller 
    def show
      @from_instance_variable = 'Expose your instance variables sparingly. Sandi Metz will love you for just using one.'
    end

And a helper somewhere that has this logic:

    def from_helpers
      "Don't use a helper; it's just bad form ... but if you must, you must."
    end

And a presenter with a little something too:

    class Presenters::Home::Index
      def from_your_presenters
        "Use your presenters. It is a pure Ruby class of your own. Mixins and inheritance just work. One presenter per view. Go!"
      end
    end

Will all go together to render some excellent HTML:

    <h1>Be Fierce</h1>
    <p>Expose your instance variables sparingly. Sandi Metz will love you for just using one.</p>
    <p>Don't use a helper; it's just bad form ... but if you must, you must.</p>
    <p>Use your presenters. It is a pure Ruby class of your own. Mixins and inheritance just work. One presenter per view. Go!</p>

#### Presenter Classes

Presenter classes should be put in the same directory structure as the view they are logic-ing:

    app/
      views/
        home/
          index.html.mustache

      presenters/
        home/
          index.rb

If you don't follow this pattern, no custom presenter will be used. Instead the mustache will be rendered with whatever it can find in controller instance variable and helpers.

Classes that initialize with a single argument will be passed a default presenter. It will have accessors to those instance variable exposed in the controller. It will also have access to locals and helper methods where appropriate.

Given the setup previously described, helpers, controllers and all:

    class Presenters::Home::Index
      attr_reader :default_presenter

      def initialize(default_presenter)
        @default_presenter = default_presenter
      end

      def contatenated_stuff
        default_presenter.from_instance_variables + ' '
          default_presenter.from_helpers + ' '
          " some other stuff"
      end
    end 

#### What about Layouts?

Layouts can be mustache too, with a presenter of their own. This is how to yield the layout content, in a very ERB-styled way:

    <!DOCTYPE html>
    <html>
      <head>
        <title>Fierce Layout</title>
      </head>
      <body>
        {{{yield}}}
      </body>
    </html>

Notice the triple curlies: `{{{yield}}}`. They allow the html to be dumped directly into the layout without being escaped in such a way that all the tags show up as text. That's the only trick.

What about using yield with an argument, you ask? Well that seems like a terrible practice, but is should work ok too: `{{{yield.head}}}`.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
