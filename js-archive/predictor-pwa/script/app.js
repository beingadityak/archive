'use strict'

if('serviceWorker' in navigator)
  {
    navigator.serviceWorker.register('../sw.js')
    .then(
      function(registration){
	registration.update();
        console.log('Service Worker Registered',registration);
      }
    );
  }

$("#btnpredict").on('click',function(){

  var min_ext = 0;
  var max_ext = 0;

  var sess1 = parseInt($('#sess1marks').val());
  var sess2 = parseInt($('#sess2marks').val());
  var sess3 = parseInt($('#sess3marks').val());
  var tot_marks = parseInt($("input[name=total]:checked").val());
  var pracvivamarks = parseInt($('#pracviva').val());
  var tgt_spi = parseInt($('#targetspi').val());
  var att_marks = parseInt($('#att').val());

  Array.prototype.average = function() {

    var sum = this.reduce(function(result, currentValue) {
        return result + currentValue
    }, 0);

    return sum / this.length;
    };

  var avg = [sess1,sess2,sess3].average();

  if(tot_marks == 150)
						{
							if(tgt_spi == 6)
								{
									var min_range = 67;
								  var max_range = 81;
									var min_ext = min_range - (avg + att_marks + pracvivamarks);
									var max_ext = max_range - (avg + att_marks + pracvivamarks);
                  showPrediction(min_ext,max_ext);
								}
							else if(tgt_spi == 7)
								{
									var min_range = 82;
									var max_range = 96;
									var min_ext = min_range - (avg + att_marks + pracvivamarks);
									var max_ext = max_range - (avg + att_marks + pracvivamarks);
                  showPrediction(min_ext,max_ext);
								}
							else if(tgt_spi == 8)
								{
									var min_range = 97;
									var max_range = 112;
									var min_ext = min_range - (avg + att_marks + pracvivamarks);
									var max_ext = max_range - (avg + att_marks + pracvivamarks);
                  showPrediction(min_ext,max_ext);
								}
							else if(tgt_spi == 9)
								{
									var min_range = 113;
									var max_range = 125;
									var min_ext = min_range - (avg + att_marks + pracvivamarks);
									var max_ext = max_range - (avg + att_marks + pracvivamarks);
                  showPrediction(min_ext,max_ext);
								}
							else if(tgt_spi == 10)
								{
									var min_range = 126;
									var max_range = tot_marks;
									var min_ext = min_range - (avg + att_marks + pracvivamarks);
									var max_ext = max_range - (avg + att_marks + pracvivamarks);
                  showPrediction(min_ext,max_ext);
								}
						}
					else if(tot_marks == 100)
						{
							if(tgt_spi == 6)
								{
									var min_range = 45;
									var max_range = 54;
									var min_ext = min_range - (avg + att_marks + pracvivamarks);
									var max_ext = max_range - (avg + att_marks + pracvivamarks);
                  showPrediction(min_ext,max_ext);
								}
							else if(tgt_spi == 7)
								{
									var min_range = 55;
									var max_range = 64;
									var min_ext = min_range - (avg + att_marks + pracvivamarks);
									var max_ext = max_range - (avg + att_marks + pracvivamarks);
                  showPrediction(min_ext,max_ext);
								}
							else if(tgt_spi == 8)
								{
									var min_range = 65;
									var max_range = 74;
									var min_ext = min_range - (avg + att_marks + pracvivamarks);
									var max_ext = max_range - (avg + att_marks + pracvivamarks);
                  showPrediction(min_ext,max_ext);
								}
							else if(tgt_spi == 9)
								{
									var min_range = 75;
									var max_range = 84;
									var min_ext = min_range - (avg + att_marks + pracvivamarks);
									var max_ext = max_range - (avg + att_marks + pracvivamarks);
                  showPrediction(min_ext,max_ext);
								}
							else if(tgt_spi == 10)
								{
									var min_range = 85;
									var max_range = tot_marks;
									var min_ext = min_range - (avg + att_marks + pracvivamarks);
									var max_ext = max_range - (avg + att_marks + pracvivamarks);
                  showPrediction(min_ext,max_ext);
								}
						}

  function showPrediction(min_ext,max_ext)
  {
    if(min_ext > 60)
      {
        min_ext = 60;
      }
    if(max_ext > 60)
      {
        max_ext = 60;
      }
    if(min_ext < 0)
      {
        min_ext = 0;
      }
    if(max_ext < 0)
      {
        max_ext = 0;
      }
      $(".min-ext-marks").html(min_ext);
      $(".max-ext-marks").html(max_ext);
  }

/*Now update results in modal*/

$(".avg-marks").html(avg);
$(".prac-viva-marks").html(pracvivamarks);
$(".att-marks").html(att_marks);
$(".tot-marks").html(tot_marks);
});
