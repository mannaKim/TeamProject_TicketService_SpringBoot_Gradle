
	 const items = document.querySelectorAll('.question');
	
	  function openCloseAnswer() {
	    const answerId = this.id.replace('que', 'ans');
	
	    if(document.getElementById(answerId).style.display === 'block') {
	      document.getElementById(answerId).style.display = 'none';
	      document.getElementById(this.id + '-toggle').textContent = '+';
	    } else {
	      document.getElementById(answerId).style.display = 'block';
	      document.getElementById(this.id + '-toggle').textContent = '-';
	    }
	  }
	
	  items.forEach(item => item.addEventListener('click', openCloseAnswer));

