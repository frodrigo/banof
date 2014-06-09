#!/usr/bin/ruby -w

$stdin.each do |l|
  if l[6..7].rstrip() == '' || l[0..1] == '99'
    next
  end

  code_dept, code_dir, code_com, id_voie, cle_rivoli, nature_voie, libelle_voie, type_commune, caractere_rur, caractere_voie, caractere_pop, pop_a_part, pop_fictive, caractere_annul, date_annul, date_creation, code_majic, type_voie, lieu_dit_bati, dernier_mot = 
    [l[0..1],l[2..2],l[3..5],l[6..9],l[10..10],l[11..14],l[15..40],l[42..42],l[45..45],l[48..48],l[49..49],l[59..65],l[66..72],l[73..73],l[74..80],l[81..87],l[103..107],l[108..108],l[109..109],l[112..119]].map{|e| e.strip()}
  if id_voie != "    "
    puts [code_dept + code_com, id_voie + cle_rivoli, nature_voie, libelle_voie, caractere_annul, type_voie, lieu_dit_bati].join('~')
  end
end
