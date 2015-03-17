$(document).ready(function() {

  $('#import-form').submit(function(event) {
    event.preventDefault();

    var linkedinUrl = $('#linkedin-url').val();

    console.log(linkedinUrl);

    $.getScript('/users/import?linkedin_url=' + linkedinUrl);

  });

  $('#add-skill').on("click", function(event){
  	event.preventDefault();

  	var newSkillField = $('#new-skill-field')

  	var skillToAdd = newSkillField.val();
  	if (skillToAdd !== "") {
  		addSkill(skillToAdd, nextSkillId());
			newSkillField.val("");
			newSkillField.focus();
  	} else {
  		console.log("Skill field empty!")
  	}
  });
});

var nextSkillId = function(){
	var skillId = 1234;
	return function(){
		skillId++;
		return skillId;
	}
}();

function addSkill(skill, skillId) {
	var skillList = $('#skill-list');
	var skillField = $('#blank-field').clone().attr("id", "skill-field-"+skillId);
	skillField.find('.skill-name').text(skill);
	skillField.find('.remove-skill').on('click', function(e){
		skillField.fadeOut(function(){
			skillField.remove();	
		});
	})
	skillField.hide();
	var hiddenTagName = 'user[skills_attributes][' + skillId + '][name]';
	var hiddenTagId = 'user_skills_attributes_' + skillId + '_name';
	var hiddenTag = $('<input type="hidden">');
	hiddenTag.attr({
		'type': 'hidden',
		'name': hiddenTagName,
		'id': hiddenTagId,
		'value': skill,
	});

	$(skillField).append(hiddenTag);
	$(skillField).find($(hiddenTagId)).val(skill);
	$(skillList).append(skillField);
	skillField.fadeIn();
};