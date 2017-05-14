<raw>
  <span></span>
  this.root.innerHTML = opts.content
  this.on('update', () => this.root.innerHTML = opts.content )
</raw>