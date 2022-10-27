# Notes
  * live_patch/2 - this method should be used in HTML markup running in the browser client
  * push_patch/2 - this method should be used in event handlers runnning on the server
  * 2 kinds of components: stateful/live (with an 'id' key) and stateless (without an 'id' key)
  * 'push_' methods are server side methods, 'live_' methods are the client side equivalent
  * phx.gen - check out all the mix generators, some really dope, useful shit here, including
  live view generation, authentication, ssl certs, channels, etc.
  * /priv/repo/seeds.exs - populate this file with the seed data for your database
  mix run priv/repo/seeds.exs will run the script
  * 3 layers: boundary, core, script
  * boundary - outer layer handling uncertainty; use 'with' statements/changesets excessively here
  * core - functions that support the boundary; predictable and reliable code, so pipe central |>
  * script - code supporting common dev, deployment or testing tasks; if database, '/priv/repo',
  if config, '/config', generally '.exs' scripts go were they're most convenient
  * views (live or not) are what's rendered to the client
  * changesets forms with changesets are used for the manipualtion of persistent data,
  but you can also use '{data, types}' tuple objects instead of schemas to create changesets
  * with form changesets, add the '%{action: :validate}' element to the changeset to enable the displaying of changeset errors
  * the error_tag/2 Phx view helper function displays the form's errors for a given field in a changeset, when the changeset's action is :validate
  * form bindings (e.g. phx-submit, phx-change) can be used for form functionality, and also to control how often and under what circumstancess LiveView JS emits form events
  * by default, forms will send a phx-change event every time the form changes
  * 'phx-debounce' and 'phx-throttle' are used to rate limit events on the client
  * LiveView gives us highly interactive file uploads
  * allow_uploads/3 funciton with the socket arguments are what enables uploads of files
  * live_file_input/2 is used to generate the HTML for a file upload form field
  * wrap it in a 'phx-drop-target' divt to enable drag-and-drop file uploads
  * check out the 'consume_uploaded_entry/3' method in the form_component.ex file - this is where we would upload data to an S3 bucket or some shit (https://www.poeticoding.com/aws-s3-in-elixir-with-exaws/)
  * we can create stateless (function) and stateful (live) components just like in react
  * a function component is a function that takes in an 'assigns' argument and returns a HEEx template
  * function components are implemented in modules that use the 'Phoenix.Component' behavior, which gives us convenient syntax for rendering
  * when created the component for the module, use 'alias __MODULE__.Component' to enable you to call it from the template, like this: '<Component.hero content="..." />'
  * Slots allow us handle custom HTML to be rendered with certain components, or rendering dynamic content within a static tag implemented by a component
  * in markup, place the Slot inside the function component: <Component.example><div>Example Slot</div></Component.example>' and in the component code, access it with 'render_slot(@inner_block)'
  * Phoenix.HTML functions are used to help render unicode characters
  * when liveview starts a live component in the parent view's process, the following callbackas are called, in order: 'preload/1', 'mount/1', 'update/2', 'render/1'
  * then, during subsequent renders of live components, the following callbackas are called, in order: 'preload/1', 'update/2', 'render/1'
  * the 'preload/1' function lets live view load all the components of the same type at once
  * as live component updates skip the 'mount/1' callback, the 'update/2' function is the safest place to establish the component's initial state
  * all live components require a single root element in their HTML templates (e.g. <div />)
  * <.live_component module={@module_name} id={@id}/> to render a live component in a HTML template
  * you can send messages from a live component to its parent using standard elixir message passing send(self(), <msg>) - we'll implement a handle_info/2 in the parent live view to handle it
  * use reducers over raw socket interactions in live views to maintain your code organisation
  * extract common helpers by refactoring with '__using__' - see 'pento_web/pento_web.ex' & 'pento_web/bar_chart.ex'
  * Phoenix.PubSub is used to publis events to send messages to every other process that expresses interest, including live views
  * Phoenix.Presence can notify you when users interact with your site - e.g. how many users are live right now: check out pento/presence.ex
  * Make sure you add the Presence module to the appliation's children, so it gets started on app start
  * Only subscribe a live view to a pubsub when the socket is connected (if connected?(socket))
  * Make sure your components are built/initialised using functional reducers, as the updates will be passed through the same flow as the initialisation, barring mount/1
  * use the function naming convention 'maybe' (e.g. maybe_track_user/1) to mark the function as conditional

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
