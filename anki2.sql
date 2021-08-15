PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE anki (
	id INTEGER NOT NULL, 
	front VARCHAR(40), 
	back VARCHAR(100), 
	example VARCHAR(240), 
	date_created DATETIME, 
	deck INTEGER, 
	count INTEGER, 
	PRIMARY KEY (id)
);
INSERT INTO anki VALUES(1,'struggle','lucha',NULL,'2021-08-09 00:00:00.000000',2,1);
INSERT INTO anki VALUES(2,'despite','a pesar de',NULL,'2021-08-09 00:00:00.000000',2,1);
INSERT INTO anki VALUES(3,'a cue to','una pista para',NULL,'2021-08-09 00:00:00.000000',2,1);
INSERT INTO anki VALUES(4,'contrived','artificioso',NULL,'2021-08-09 00:00:00.000000',2,1);
INSERT INTO anki VALUES(5,'rather','bastante',NULL,'2021-08-09 00:00:00.000000',2,1);
INSERT INTO anki VALUES(6,'outweighed','contrarestado',NULL,'2021-08-09 00:00:00.000000',2,1);
INSERT INTO anki VALUES(7,'in disguise','disfrazado','Where some of those attributes actually behaviors in disguise?','2021-08-09 00:00:00.000000',2,1);
INSERT INTO anki VALUES(8,'unforeseen','inesperado/ imprevisto','It can lead to unforeseen results and security vulnerabilities','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(9,'overlook','pasar por alto/ omitir / ignorar','They are often overlooked due to the SQLAlchemy ORM.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(10,'overhead','sobrecarga / gastos generales / aereo / sobre la cabeza','This does add some extra database usage and overhead when using the OMR.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(11,'outweigh','superar sobrepasar compensar','the pluses of having this capability far outweigh the drawbacks.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(12,'drawback','inconveniente desventaja devolucion','In terms of convenience, inkjet printers haveone drawback.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(13,'incantation','conjuro encantamiento hechizo','you are not strong enough to survive this incantation.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(14,'so far','hasta ahora/ hasta el momento/ hasta la fecha/ tan lejos','So far, we''ve specified addresses as single line numbers.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(15,'nail','clavo','Paul hammered a nail into the wall and hung a picture on it.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(16,'forgiveness','perdon disculpas','I''s sometimes better to ask for forgiveness than to ask for permission.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(17,'frowned','fruncir el ceño','Kate frowned as she tried to work out the difficult equation.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(18,'leap','saltar brincar','Sarah jumped over the stream with a leap.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(19,'daunting','abrumador/ sobrecogedor/ desalentador','Jessie was daunted by the idea of living with her parents again.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(20,'mild','leve suave','The weather is usually mild in the spring.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(21,'tightly','firmemente / ajustado','Harriet tied the parcel tightly. (ato el paquete firmemente)','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(22,'lend','prestar','The library lends books if you are a local resident.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(23,'grasp','captar agarrar entender','Mike grasped his bag tightly on the subway.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(24,'hold/held','agarrar/contener/abrazar/esperar','She holds her child''s hand when they cross the street.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(25,'detour','desvio / rodeo','The highway is closed, so we''ll have to take a detour.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(26,'swap','intercambio/ permutar','Billy swaps football cards with his friends.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(27,'accustomed','acostumbrado','Liz took her accustomed seat in class.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(28,'fellow','hombre sujeto compañero socio','He''s just some fellow I met on the bus.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(29,'sparinly','con moderacion','Use the double cream sparinly, as too much isn''t good for you.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(30,'replenish','reponer rellenar','Ellen replenished her supply of biscuits.','2021-08-09 00:00:00.000000',1,0);
INSERT INTO anki VALUES(31,'seamlessly','sin problemas perfectamente a la perfeccion','Adobe integrates seamlessly with all the popular file formats.','2021-08-10 00:00:00.000000',1,0);
INSERT INTO anki VALUES(32,'attainable','posible alcanzable asequible','Remember that hard requirements are objectively attainable goals.','2021-08-10 00:00:00.000000',1,0);
INSERT INTO anki VALUES(33,'reign','reinado reinar gobierno','Peace must reign, understanding and helping among human beings.','2021-08-10 00:00:00.000000',1,0);
INSERT INTO anki VALUES(34,'haphazardly','al azar sin orden ni concierto caprichosamente','Users who have to jump around a form haphazardly to match their workflow are more likely to make mistakes.','2021-08-10 00:00:00.000000',1,0);
INSERT INTO anki VALUES(35,'clerk','empleado secretario recepcionista','That way data entry clerks can zip right through the form...','2021-08-10 00:00:00.000000',1,0);
INSERT INTO anki VALUES(36,'bounce','rebote rebotar','without having to bounce around the screen.','2021-08-10 00:00:00.000000',1,0);
INSERT INTO anki VALUES(37,'mockup','maqueta prototipo','Take a moment to make a mockup of your form using paper and pencil.','2021-08-10 00:00:00.000000',1,0);
INSERT INTO anki VALUES(38,'readily','facilmente rapidamente inmediatamente','It''s readily avalaible on both your development and target platforms.','2021-08-10 00:00:00.000000',1,0);
INSERT INTO anki VALUES(39,'mistakenly','erroneamente equivocadamente','in case you mistakenly assign your variable to it.','2021-08-10 00:00:00.000000',1,0);
COMMIT;
