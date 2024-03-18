Pokemon_App is a Rails project to create a fully functional Pokemon encounter and battle simulator complete with random/custom trainer battles.

Pokemon_App utilizes the HTTParty and Nokogiri gems to scrape serebii.com's national dex page when seeding its database with the base pokemon models. 
<h1> Currently Features:</h1>
<ul>
  <li> Functional User signup/login </li>
  <li> Trainer generation </li>
  <li> Unique pokemon generation, complete with EV's, IV's, Natures, and Levels  </li>
  <li> Team generation </li>
  <li> Unique pokemon-trainer ownership </li>
  <li> Team-trainer ownership </li>
  <li> A functional html frontend for those features </li>
</ul>
[backend repo](https://github.com/JPaoloMaloles/Tftraitors_backend)

<h1> Getting Started </h1>
<h3> Setup:</h3>
In your terminal:
<div></div>
<ol>
<li>Clone the repository and enter the project folder
<pre><code>git clone https://github.com/JPaoloMaloles/PokemonGenerator.git
cd PokemonGenerator
</code></pre></li>
<li>Install gems
<pre><code>bundle install
</code></pre></li>
<li>Seed the database
<pre><code>rails db:reset
</code></pre></li>
<li>Host the rails server
<pre><code>rails s
</code></pre></li>
<li>Head to the url 'localhost:3000' or whichever port the server is open in</li>
</ol>

<h1> Roadmap:</h1>
