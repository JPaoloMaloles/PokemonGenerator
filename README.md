Pokemon_App is a Rails project to create a fully functional Pokemon encounter and battle simulator complete with random/custom trainer battles.

Pokemon_App utilizes the HTTParty and Nokogiri gems to scrape serebii.com's national dex page when seeding its database with the base pokemon models. 
<h1> Current Features</h1>
<ul>
  <li> Functional User signup/login </li>
  <li> Trainer generation </li>
  <li> Unique pokemon generation, complete with EV's, IV's, Natures, and Levels  </li>
  <li> Team generation </li>
  <li> Unique pokemon-trainer ownership </li>
  <li> Team-trainer ownership </li>
  <li> A functional html frontend for those features </li>
</ul>

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

<h1> Usage </h1>
To access PokemonGenerator's features users must be logged into an account:
<ol>
  <ul>Click "Sign Up" to create new user. Upon successful completion, you will be automatically signed in and a default trainer will be assigned active to your user.</ul>
</ol>
Generating and Managing your pokemon
<ol>
  <li>Click "Your Pokemon" to view the pokemon your trainer owns.</li> 
  <li>Randomly generate a pokemon by clicking "New Unique Pokemon", then clicking "Create Unique Pokemon", a nickname is optional.</li>
  <li>You may delete the pokemon by clicking "destroy unique pokemon" or return to pokemon you own by clicking "back to your own pokemon"</li>
</ol>
Creating and Managing your teams
<ol>
  <li>Click "Your Teams" to view the teams your trainer owns</li>
  <li>Click "New Team" to create a new team for your trainer</li>
  <li>Click "New Pokemon In Team" to assign pokemon you own to that team. A pokemon can only be assigned to one team at a time.</li>
  <li>Click "Go to page" to view all the team in detail.</li>
  <li>Click "Go to page" to view that pokemon's page.</li>
  <li>Click "Switch Pokemon in Box" to switch that pokemon with another pokemon that you own that is not on a team</li>
  <li>Click "Remove Pokemon from team" to remove that pokemon from that team</li>
</ol>
Creating and Managing your trainers
  <ol>
  <li>Click "Your Trainers" to view the trainer you own.</li>
  <li>Click "Go to Page" To view all the pokemon that trainer owns</li>
  <li>Click "Set Current Trainer" to change active trainer.</li>
  <li>Click "Destroy Trainer" to delete that trainer</li>
  <li>Click "New Trainer" then "Create Trainer" to create a new Trainer. Newly created trainers will <i><b>not</b></i> be automatically set to current trainer.</li>
  
  
  
</ol>

<h1> Roadmap</h1>
