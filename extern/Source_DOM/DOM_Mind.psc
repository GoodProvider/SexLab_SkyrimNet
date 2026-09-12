Scriptname DOM_Mind extends ReferenceAlias  
Import Utility
Import DOM_Util
Import DOM_EquipUtil

;/ Description
Training:
+==================+==================+==================+==================+==================+==================+==================+==================+==================+==================+
| primary stat     | secondary stat   | feeling          | love & loyalty   | consequence      | emotion          | trait+facet      | trait            | facet            | link to abuse    |
+==================+==================+==================+==================+==================+==================+==================+==================+==================+==================+
| submission       + vag/crime/trainer| Am I in danger?  | desire           | dominated        | pain             | humility         | Honesty          | Wilpower         | sexual           |
+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+
| fear             + combat/anal      | What can I do?   | worship          | powerless        | fear             | fearfulness      | Emotionality     | Toughness        | phys             |
+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+
| humiliation      + oral/crime/train | Noone should know| fascination      | degraded         | shame            | composure        | eXtraversion     | Sensuality       | sexual and psy   |
+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+
| anger            + pose/vaginal     | Is it my fault?  | absolution       | guilt            | stress           | forgiveness      | Agreeableness    | Submissivity     | psychological    |
+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+
| resignation      + house/oral       | Can I escape?    | devotion         | hopelessness     | sorrow           | prudent          | Conscientiousness| Boldness         | phys and psy     |
+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+------------------+
| respect          + anal             | Am I worthless?  | admiration       | low self-esteem  | discipline       | unconventionality| Openness         | Smart            | sexual and phys  |
+==================+==================+==================+==================+==================+==================+==================+==================+==================+==================+
| Stockholm syndrom+ PTSD events      | How do I survive?| dependence       | love             |         x        |         x        |         x        | all              |
+==================+==================+==================+==================+==================+==================+==================+==================+==================+==================+

Emotions and facets 6x6: (* means listed in HEXACO model)
+==================+==================+==================+==================+==================+==================+
| DOM Function     | HEXACO facet     | trait            | 2nd trait        | 3rd trait        | components       |
+==================+==================+==================+==================+==================+==================+
| pain             | humility*        | +Honesty         | -Wilpower        | -Toughness       | sexual and phys  | hability to lower one's pride
+------------------+------------------+------------------+------------------+------------------+------------------+
| trauma           | sincerity*       | +Honesty         | -Toughness       | +Agreeableness   | physical         | genuine in interpersonal relations
+------------------+------------------+------------------+------------------+------------------+------------------+
| cooldown         | modesty*         | +Honesty         | +Sensuality      | -Emotionality    | sexual           | tendency to be modest and unassuming
+------------------+------------------+------------------+------------------+------------------+------------------+
| -training        | sensitivity      | +Honesty         | +Submissivity    | -eXtraversion    | sexual and psy   | opposite of coldness, taking into account others point of view
+------------------+------------------+------------------+------------------+------------------+------------------+
| -greed           | greed avoidance* | +Honesty         | +Boldness        |+Conscientiousness| phys and psy     | uninterested in wealth and luxury godds
+------------------+------------------+------------------+------------------+------------------+------------------+
| -criminality     | fairness*        | +Honesty         | -Smartness       | +Openness        | psychological    | opposite of immorality, tendency to avoid fraud and corruption
+==================+==================+==================+==================+==================+==================+
| pressure         | panicky          | +Emotionality    | -Wilpower        | -Boldness        | sexual and phys  |
+------------------+------------------+------------------+------------------+------------------+------------------+
| fear             | fearfulness*     | +Emotionality    | -Toughness       | +eXtraversion    | physical         | tendency to experience fear
+------------------+------------------+------------------+------------------+------------------+------------------+
| love             | sentimentality*  | +Emotionality    | +Sensuality      | +Smart           | sexual           | feel strong emotional bonds with others
+------------------+------------------+------------------+------------------+------------------+------------------+
| joy              | impressionable   | +Emotionality    | +Submissivity    | +eXtraversion    | sexual and psy   |
+------------------+------------------+------------------+------------------+------------------+------------------+
| jealousy         | dependence*      | +Emotionality    | -Boldness        | -Honesty         | phys and psy     | need for emotional support from others
+------------------+------------------+------------------+------------------+------------------+------------------+
| distress         | anxiety*         | +Emotionality    | +Smart           |+Conscientiousness| psychological    | worry in a variety of contexts even for minor problems
+==================+==================+==================+==================+==================+==================+
| energy           | liveliness*      | +eXtraversion    | -Wilpower        | +Agreeableness   | sexual and phys  | enthusiasm and energy without focus
+------------------+------------------+------------------+------------------+------------------+------------------+
| self-esteem      | self-esteem*     | +eXtraversion    | +Toughness       | -Honesty         | physical         | generally satisfied with themselves and consider themselves to have likable qualities
+------------------+------------------+------------------+------------------+------------------+------------------+
| -shame/naivety   | composure        | +eXtraversion    | -Sensuality      | +Openness        | sexual           | opposite of naivety
+------------------+------------------+------------------+------------------+------------------+------------------+
| bondage          | sociability*     | +eXtraversion    | +Submissivity    | -Toughness       | sexual and psy   | tendency to enjoy conversation, social interaction, and parties
+------------------+------------------+------------------+------------------+------------------+------------------+
| daring           | social boldness* | +eXtraversion    | +Boldness        | +Sensuality      | sexual and phys  | comfort or confidence within a variety of social situations
+------------------+------------------+------------------+------------------+------------------+------------------+
| -ingenuity       | self-control     | +eXtraversion    | +Smart           | -Emotionality    | psychological    | opposite of ingenuity / When body gets pleasure while the mind is trying to fight it
+==================+==================+==================+==================+==================+==================+
| guilt            | gentleness*      | +Agreeableness   | -Wilpower        | +Honesty         | sexual and phys  | tendency to be mild and lenient in dealings with other people
+------------------+------------------+------------------+------------------+------------------+------------------+
| -stress          | patience*        | +Agreeableness   | +Toughness       | -Submissivity    | physical         | opposite of anger, remain calm rather than becoming angry
+------------------+------------------+------------------+------------------+------------------+------------------+
| pose             | flexibility*     | +Agreeableness   | +Sensuality      | +eXtraversion    | sexual           | willingness to compromise and cooperate with others
+------------------+------------------+------------------+------------------+------------------+------------------+
| anger            | forgiveness*     | +Agreeableness   | +Submissivity    | +Emotionality    | sexual and psy   | willingness to feel trust and liking toward those who may have caused one harm
+------------------+------------------+------------------+------------------+------------------+------------------+
| injustice        | empathy          | +Agreeableness   | +Boldness        | +Openness        | phys and psy     | empathy to others and reaction to injustice especially towards friends
+------------------+------------------+------------------+------------------+------------------+------------------+
| -resentment      | contentment      | +Agreeableness   | -Smart           |-Conscientiousness| psychological    | show contentment in most situations, not easily annoyed by unfairness
+==================+==================+==================+==================+==================+==================+
| scolding         | laborious        |+Conscientiousness| -Wilpower        | -Smart           | sexual and phys  | tendency to work hard without benefits or discussing orders
+------------------+------------------+------------------+------------------+------------------+------------------+
| combativity      | diligent*        |+Conscientiousness| +Toughness       | -Submissivity    | physical         | tendency to work effectively with benefits
+------------------+------------------+------------------+------------------+------------------+------------------+
| comfort          | consideration    |+Conscientiousness| +Sensuality      | +Honesty         | sexual           | taking pleasure being in an organized environment
+------------------+------------------+------------------+------------------+------------------+------------------+
| house            | perfectionism*   |+Conscientiousness| +Submissivity    | +Wilpower        | sexual and psy   | tendency to be thorough and concerned with details
+------------------+------------------+------------------+------------------+------------------+------------------+
| sorrow           | prudent*         |+Conscientiousness| -Boldness        | +Agreeableness   | phys and psy     | tendency to deliberate carefully and to inhibit impulses
+------------------+------------------+------------------+------------------+------------------+------------------+
| praising         | organized*       |+Conscientiousness| -Smart           | -Openness        | psychological    | tendency to seek order, particularly in one's physical surroundings
+==================+==================+==================+==================+==================+==================+
| -authority       | independance     | +Openness        | +Wilpower        |-Conscientiousness| sexual and phys  | tendency to discuss authority
+------------------+------------------+------------------+------------------+------------------+------------------+
| rebellion        | inquisitiveness* | +Openness        | +Toughness       | +Wilpower        | physical         | seek information about, and experience with, the natural and human world
+------------------+------------------+------------------+------------------+------------------+------------------+
| hope             | appreciation*    | +Openness        | +Sensuality      | +Agreeableness   | sexual           | enjoyment of beauty in art and in nature
+------------------+------------------+------------------+------------------+------------------+------------------+
| -manipulation    | curiosity        | +Openness        | -Submissivity    | -Emotionality    | sexual and psy   | tendency to open to sudden new events
+------------------+------------------+------------------+------------------+------------------+------------------+
| imagination      | creativity*      | +Openness        | +Boldness        | +Sensuality      | phys and psy     | preference for innovation and experiment
+------------------+------------------+------------------+------------------+------------------+------------------+
| -discipline      | originality*     | +Openness        | +Smart           | -Honesty         | psychological    | assesses a tendency to accept the unusual
+==================+==================+==================+==================+==================+==================+

H E  X A  C  O
9 10 9 10 10 9
W T S Sb B Sm
8 9 9 10 5 7

Extra:
vaginal = +honest +kind +sensual
oral    = -lively +(perv/sensual) +cons
anal    = +perv -open +anxious
orgasm  = +sensual, +perv, -tough ; purely physical
addict  = -honest -kind -cons     ; purely psychological
combat  = all facets ; no link to HEXACO

Skills: trainer skills learnt by practicing
	Enforcer   = link with insensitivity(submission) sexual and phys,   Boost: pain,                      Action: pain/tie-up,                           Kink: punishing/tying-up slaves, Praise: being a good trainer
	Persuader  = link with intilidate(fear)          physical,          Boost: tell/strip/pose     		  Action: scold/strip/pose,                      Kink: objectifying slaves,       Praise: being a scary trainer
	Depraver   = link with self_esteem(humiliation)  sexual,            Boost: arousal,check              Action: insult/rip-off/masturbate/grab,        Kink: humiliating slaves,        Praise: being a good sex trainer
	Predator   = link with resentment(anger)         sexual and psy,    Boost: rape,comfort,maid          Action: flatter/comfort/rape/capture,          Kink: training sex slaves,       Praise: being a lustful trainer
	Slaver     = link with Controller(resignation)   phys and psy,		Boost: display/shower/threats     Action: promise/threaten/shower/pricing/brand, Kink: managing slaves,           Praise: being a good housemistress
	Deceiver   = link with pretender(respect)        psychological,     Boost: praise/sacrifice/kiss/sex  Action: praise/kiss/sex,                 	     Kink: breaking slaves,           Praise: being a devoted trainer         

Boost: ORGASM, love

; Sexy seven personality dimensions (correlation factors ~0.3 0.2 0.15
;   1. Sexual attractiveness (open, lively, kind) physical self esteem
;   2. Relationship exclusivity (honest, -open, cons) exclusive romantic relations
;   3. Gender orientation (no correlation) how much identify with own gender = -guilt
;   4. Sexual restraint (-lively, -open, cons) self restraint of sexual urges = -frequent sex and +regret
;   5. Erotophilic disposition (+++sensual, -cons, anxious, open) = sensual trait
;   6. Emotional investment (kind, lively) depth of romantic investment = +intimacy, -controling
;   7. Sexual orientation (-open, cons) 100% = 100% sure of sexual orientation, 0% = no sexual orientation
; The Extraversion factor is associated with the Sexy Seven scales of Emotional Investment and Sexual Attractiveness
; Honesty–Humility and Agreeableness were related to restricted Sociosexual Orientation
; and to the Sexy Seven variables of Relationship Exclusivity and (low) Erotophilic Disposition. 


Abuse negative (mean) and positive (manipulative): psychological, physical and sexual
float physNegAbuse, ...
Type of abuse: violence, threats, rape, degradation, isolation
psyc and sexual abuses are more damaging than physical.

manipulative -60H -52C
defend others: AE
depression: +59E -39X -14C +O
seen as easy to manipulate: +EA -XCO
victim -A+O-C
bully -HEAC

Abuse:
  - Consequences: fear, sadness, shame (of others learning what happenned), guilt (it's the victim fault)
PTSD:
  
SS:
  - To happen SS needs: threat to life and abuse, tiny sign of kindness, isolation (from possible rescuers), no escape possible
  - SS is a survival mecanism: in front of life threatening abuser, victim looks for a way out, only way out is bounding with abuser
  - Cycle: 1) tension arise 2) abuse happen releasing abuser tension 3) make nice with blame on victim, victim feels helpless since the abuser is the one to blame
  - As cycles go on victim feels depressed and becomes passive toward abuse (broken)
  - Consequences: 
		1) Guilt: blaming self for abuse "it's my fault, I won't do it again, sorry"
		2) Confusion/Delusion/Denial: the victim can not place the fault on anyone, minimizing and denying abuse "it's not your fault" 
		3) Anxious/Stress: fear for their life or friends' "don't hurt me"
		4) Powerless/Depression: the victim feels the abuser is omniscient and omnipresent "I am never going to escape this hell"
		x) staying (or even going back to) "I am better here than alone"
		y) siding with abuser "you did it because you had to" 
		z) finally love for the abuser "you are not so bad afterall"
  
MOODS:
======

 Free moods:
  - Neutral      = NPC is neutral, might be pondering the situation.
  - Fine         = NPC is fine, doesn't apply for slaves.
  - Happy        = NPC is happy, doesn't apply for slaves.
  - Charmed      = NPC is charmed by the player, could be inlove, doesn't apply for slaves.
  
 Starting mood depends on personality immediate response to danger:
  - Angry        = mind says fight back         -> More sensitive to physical abuse.
  - Crushed      = mind says this didn't happen -> More sensitive to sexual and psychological abuse.
  - Afraid       = mind says run away           -> More sensitive to psychological abuse.
  - Terrified    = mind is paralyzed            -> More sensitive to sexual abuse.
  - Proud        = mind says this didn't happen -> More sensitive to sexual and physical abuse.
  
 Secondary moods happen after the mind got time to rest and evaluate the situation:
  - Defiant      = mind says find a way out                -> Sensitive to sexual and psychological abuse.
  - Sad          = mind realizes there is no hope          -> More sensitive to physical abuse.
  - Afraid       = mind realizes surviving means obey      -> More sensitive to psychological abuse.
  - Shame        = mind is confused by physical sensations -> More sensitive to sexual abuse.
  
 Third stage and Special moods happen after some abuse have been endured:
  - JustCaptured = slave didn't realize or is in shock of being captured.
  - Shock        = mind is switching off for a moment to recover.
  - Broken       = mind can not think clearly and is not trying to find a way out anymore.
  
 Fourth stage moods happen when the victim sides with the abuser:
  - Loyal        = the victim would get killed to protect the abuser.
  - In Love      = the abuser is the One.
  - Jealous      = the victim is the only one able to take care of the abuser.
  - Depressed    = the victim feels neglected and sad.
  - Insecure     = the victim feels valueless and unwanted.
  
/;

; ### Main properties ###
DOM_Core Property DOM01 Auto
Actor Property PlayerRef Auto Hidden

; ### Local variables ###
String name = "Unnamed Mind"
String title
Actor Property akRef Auto Hidden
DOM_Actor Property actor_alias Auto Hidden
int actorSex = 1
int actorType = 0 ; 0 = NPC, 1 = Animal, 2 = Creature
string actorPossessive
string actorObjective
string actorPronoun
string actorBeVerb
int actorLevel

; ### Mood Handler ###
int mood_swing_ticks = 0
int mood_swing_max = 30

bool Property canChangeMood = true Auto Hidden
bool mood_is_busy = false
String __mood = "just_captured"
String Property mood Hidden
	String Function get()
		return __mood
	EndFunction
	Function set(String value)
		if mood_is_busy
			;LogTrace("can not change mood is busy")	
			return
		endif
		if IsPassedOut() && value != "just_captured"
			;LogTrace("can not change mood actor is unconscious or asleep or drunk")	
			return
		endif
		;LogTrace("set mood from "+__mood+" to "+value+" canChangeMood="+canChangeMood)	
		if __mood != value || value == "shock" || value == "just_captured"
			if canChangeMood
				mood_is_busy = true
				__mood = value
				EndMood()
				mood_is_busy = false
				GoToState(__mood)
				mood_swing_ticks = 0
				if MOD_Anxiety <= 1.0
					mood_swing_max = ((1.0-MOD_Anxiety)*20.0+25.0) as int
				else
					mood_swing_max = (20.0-MOD_Anxiety) as int
				endif
				StartMood()
				RegisterForUpdateChanceRunAway()
				RegisterForUpdateChanceRunAwayGang()
				actor_alias.TryWearClothes(true)
				DOM01.DOM04.NotifyChangeMood(actor_alias)
				actor_alias.SendExternalEventSS("MoodChange",__mood)
			endif
		endif
	EndFunction
EndProperty

Function StartMood()
EndFunction

Function EndMood()
EndFunction

Function OnResilienceUpdate()
	if !DOM01.resilienceToggle
		return
	endif
	if !is_player_slave
		return
	endif
	if IsDevoted()
		return
	endif
	float current_time               = GetCurrentGameTime()
	float time_since_last_resilience = current_time-time_last_resilience
	float time_since_last_abused     = current_time-time_last_abused
	float time_check_resilience
	if MOD_Hope	> 0.0
		time_check_resilience = 2.0-MOD_Hope/5.0
	else
		time_check_resilience = 2.0
	endif
	float time_check_abused
	if MOD_Rebellion	> 0.0
		time_check_abused = 2.0-MOD_Rebellion/5.0
	else
		time_check_abused = 2.0
	endif
	if time_since_last_resilience < time_check_resilience ; Check resilience once per arpund a day, dependd on personality
		return
	endif
	if time_since_last_abused < time_check_abused ; Check resilience almost everyday without punishment
		return
	endif
	;LogTrace("OnResilienceUpdate time_since_last_resilience="+time_since_last_resilience+" / "+time_check_resilience)
	;LogTrace("OnResilienceUpdate time_since_last_abused="+time_since_last_abused+" / "+time_check_abused)
	TrainSubmission(-MOD_Insensitivity)
	TrainFear(-MOD_Criminality)
	TrainHumiliation(-MOD_SelfEsteem)
	TrainAnger(-MOD_Resentment)
	TrainResignation(-MOD_Hope)
	TrainRespect(-MOD_Rebellion)
	time_last_resilience = GetCurrentGameTime()
EndFunction

Function OnMoodUpdate()
EndFunction

Function OnMoodUpdateGameTime()
EndFunction

Event OnExperiencePain()
EndEvent

Event OnEndSex(bool had_orgasm)
EndEvent

bool Function IsBrokenToObey() ; will obey because of broken (not fear, not devoted)
	return false
EndFunction

bool Function IsScaredToObey() ; will obey because of fear
	return false
EndFunction

bool Function IsWillingToObey() ; will obey because is well trained
	float xh = humiliation+DOM_Util.RandG50()*MOD_Naivety
	float xs = submission+DOM_Util.RandG50()*MOD_Humility
	float xr = resignation+DOM_Util.RandG50()*MOD_Prudent
	LogTrace("IsWillingToObey xh="+xh+" xs="+xs+" xr="+xr)
	if(xh>50.0 && xs>50.0 && xr>50.0)
		return true
	endif
	return false
EndFunction

bool Function IsWillingToClean()
	if IsObedient()
		;LogTrace("IsWillingToClean obedient")
		return true
	endif
	if (RandomFloat() < MOD_Perfectionism || RandomFloat()*100.0 < house_training)
		;LogTrace("IsWillingToClean trained")
		return true
	endif

	if WillObeyBecausePunished(10,0.5)
		;LogTrace("IsWillingToClean punished")
		SetObedientTimer(10)
		return true
	endif
	
	int was_warned = WillObeyBecauseWarned(10,0.5)
	if was_warned > 0
		;LogTrace("IsWillingToClean warned")
		SetObedientTimer(10)
		return true
	endif
	
	;LogTrace("IsWillingToClean NO")
	SetNextPunishmentReasonSilent(10) ; "being a bad maid"
	return false
EndFunction

bool Function IsWillingToWork()
	if IsObedient()
		;LogTrace("IsWillingToWork obedient")
		return true
	endif
	if actor_alias.has_leash || actor_alias.is_leashed
		return true
	endif
	bool work_bonus = 0.0
	if actor_alias.has_collar || actor_alias.has_device
		work_bonus = 30.0
	endif
	
	if (RandomFloat() < MOD_Authority || RandomFloat()*100.0 < work_training+work_bonus)
		;LogTrace("IsWillingToWork trained")
		return true
	endif

	if WillObeyBecausePunished(10,0.5)
		;LogTrace("IsWillingToWork punished")
		SetObedientTimer(10)
		return true
	endif
	
	int was_warned = WillObeyBecauseWarned(10,0.5)
	if was_warned > 0
		;LogTrace("IsWillingToWork warned")
		SetObedientTimer(10)
		return true
	endif
	
	;LogTrace("IsWillingToWork NO")
	SetNextPunishmentReasonSilent(30) ; "being a bad worker"
	return false
EndFunction

bool Function IsObedient() ; will obey
	return true
EndFunction

bool Function IsDevoted() ; will obey because of devotion
	return false
EndFunction

bool Function IsInLove()
	return false
EndFunction

bool Function IsHappy()
	return false
EndFunction

bool Function IsOkayWithPlayer()
	if IsInLove()
		return true
	endif
	if IsHappy()
		return true
	endif
	if IsDevoted()
		return true
	endif
	if mood == "broken"
		return true
	endif
	if __chance_broken > 74.0
		return true
	endif
	if __chance_inlove > 74.0
		return true
	endif
	if __chance_charmed > 74.0
		return true
	endif
	if __chance_happy > 74.0
		return true
	endif
	return false
EndFunction

bool Function IsAngry()
	return false
EndFunction

bool Function IsAfraid()
	return false
EndFunction

bool Function IsShocked()
	return false
EndFunction

bool Function IsAshamed()
	return false
EndFunction

bool Function IsSad()
	return false
EndFunction

bool Function IsCrying()
	if actor_alias.hasTears()
		return true
	endif
	return false
EndFunction

bool Function IsShamed()
	if actor_alias.is_shamed
		return true
	endif
	return false
EndFunction

bool Function IsFeelingJealous() ; feels jealous even though mood is not necessarily jealous
	if RandomFloat() < __chance_jealous
		return true
	endif
	return false
EndFunction

bool Function IsFeelingAshamed() ; feels ashamed even though mood is not necessarily ashamed
	if RandomFloat() < __chance_ashamed
		;LogTrace("IsFeelingAshamed: true "+__chance_ashamed)
		return true
	endif
	return false
EndFunction

float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
	return MOD_Anxiety
EndFunction

float Function getRapeMultiplier()
	return MOD_Liveliness
EndFunction

float Function getPainMultiplier()
	return MOD_Sincerity
EndFunction

float Function getPraiseMultiplier() ; How much this mood affects prasing efficiency
	return MOD_Organized
EndFunction

float Function getScoldMultiplier() ; How much this mood affects scolding efficiency
	return MOD_Laborious
EndFunction

float Function getFeelingMultiplier() ; How much this mood is dominated by feelings (thoughts)
	return MOD_Sociability
EndFunction

float Function getEmotionMultiplier() ; How much this mood is dominated by emotions (instant)
	return MOD_Panic
EndFunction

float Function getArousalBonus()
	return 0.0
EndFunction

Float Function RunAwayMoodBase()
	return 0.0
EndFunction

Float Function CallForHelpMoodBase()
	return 0.0
EndFunction

Float Function StopWaitingMoodBase()
	return 0.0
EndFunction

Float Function BreakRestraintMoodBase()
	return 0.0
EndFunction

Float Function StopOrderMoodBase(float training)
	return 0.0
EndFunction

string Function GetMoodName()
	return mood
EndFunction

string Function GetMoodNameThirdPerson()
	return ""
EndFunction

Function ChooseIdle()
	if actor_alias.canIdle
		ChooseDefaultIdle()
	endif
	ChooseDrunkIdle() ; return to drunk state
EndFunction

Function ChooseDrunkIdle()
	if __drunk_level == 0
		return
	endif
	Wait(5.0*MOD_Prudent)
	actor_alias.Anim_DrunkReset()
EndFunction

Function ChooseTopic()
EndFunction

; ### Setup and teardown ###
Event OnBootstrap(string eventName = "", string strArg = "", float numArg = 0.0, Form sender = None)
	;LogTrace("OnBootstrap()")
	UnregisterForModEvent("DOMBootstrap")
	if GetActorRef() != None
		AfterAssign(is_slave,false,is_player_slave)
	else
		BeforeClear()
		akRef = None
	endif
EndEvent

Event OnLoad()
	;LogTrace("OnLoad()")
	SetProperties(is_slave,is_player_slave)
EndEvent

Event AfterAssign(bool isSlave, bool newActor, bool playerOwned)
	; Setup
	akRef = GetActorRef()
	actor_alias  = (self as ReferenceAlias) as DOM_Actor
	SetMindBusy()
	Debug.Trace("DOM_Mind: "+akRef.GetDisplayName()+": AfterAssign start actor isSlave="+isSlave+" newActor="+newActor+" playerOwned="+playerOwned+" "+ self + " is " + akRef)
	ClearValues()
	if akRef == DOM01.PlayerRef
		LogTrace("AfterAssign actor is player")
		is_player_actor = true
	else
		LogTrace("AfterAssign actor is NOT player")
		is_player_actor = false
	endif
	LogTrace("AfterAssign akRef="+akRef+" player="+DOM01.PlayerRef)
	is_slave = IsSlave
	is_player_slave = playerOwned
	if is_player_slave
		SetSlaveOwner(PlayerRef)
	endif
	if isSlave ; assign without running mood change code
		if newActor
			__mood = "just_captured"
		else
			__mood = "afraid"
		endif
	else 
		__mood = "fine"
	endif
	__arousal_factor = DOM01.DOMSexlab.HandleArousalAfterAssign(akRef,actorSex)
	SetProperties(isSlave,playerOwned)
	LogTrace("AfterAssign is_player_actor="+is_player_actor+" is_slave="+is_slave+" newActor="+newActor+" should_wear_armor="+should_wear_armor+" mood="+mood)

	; is player love interest
	SetLoveInterest()

	; generate personality traits and save them into factions
	LogTrace("AfterAssign set personality mood="+mood+" "+ self + " is " + akRef)
	SetPersonality(newActor)
	actorLevel = GetActorLevel()
	DOM01.DOMPAH.ClearTrainingFactions(akRef)
	if memory_capture_time == 0
		memory_capture_time = GetCurrentGameTime()
	endif
	if !isSlave ; || submission != 0.0
		ResetMood()
	elseif newActor
		canChangeMood = true
		mood = "just_captured"
	else
		ResetMood()
	endif
	SetRelationshipToPlayer()
	RegisterModEvents()
	
	SetMindReady()
	if !isSlave
		;LogTrace("AfterAssign NotifyIsRecruited")
		DOM01.DOM04.NotifyIsRecruited(actor_alias)
		actor_alias.SendExternalEventSSB("Recruited",mood,newActor)
	else ; if isSlave
		DOM01.NPCCheckForceGreet()
	endif
	ActorUtil.RemovePackageOverride(akRef, DOM01.DOMFollowPlayerAndWait)
	ActorUtil.RemovePackageOverride(akRef, DOM01.DOMFamilyForceGreet)
	;LogTrace("AfterAssign is_slave="+is_slave+" newActor="+newActor+" should_wear_armor="+should_wear_armor)
	LogTrace("AfterAssign done mood="+mood+" "+ self + " is " + akRef)
EndEvent

Function SetObedientTimer(int timer_start = 10)
	int new_timer_obedient = timer_start + ((MOD_Laborious - MOD_Rebellion) as int)
	if timer_obedient <= 0 
		timer_obedient = new_timer_obedient
	else
		timer_obedient = timer_obedient/10
		timer_obedient = new_timer_obedient + timer_obedient
	endif
	;LogTrace("SetObedientTimer="+timer_obedient)
EndFunction

Function ApplyPredatorBonusAtCapture()
		float mod = 10.0*DOM01.GetPredatorModifier(None)
		if mod <= 0.0
			return
		endif
		TrainSubmission(mod)
		TrainFear(mod)
		TrainResignation(mod)
EndFunction

Function ResetMood()
	canChangeMood = true
	;LogTrace("ResetMood canChangeMood="+canChangeMood)
	string the_mood = GetMoodByFaction()
	CheckMoodFactions()
	if the_mood == "just_captured" || the_mood == "" || the_mood == "neutral" || the_mood == "empty_minded"
		LogTrace("ResetMood spontaneous canChangeMood="+canChangeMood)
		ChooseMoodSpontaneous(1.0)
		LogTrace("ResetMood spontaneous canChangeMood="+canChangeMood+" mood="+mood)
	elseif __mood != the_mood ; force reset
		mood = the_mood
		LogTrace("ResetMood faction canChangeMood="+canChangeMood+" mood="+mood)
	endif
	if mood == "just_captured"
		mood = "afraid"
		LogTrace("ResetMood afraid canChangeMood="+canChangeMood+" mood="+mood)
	endif
	LogTrace("ResetMood() mood="+__mood)
EndFunction

Function SetGender()
	actorType = DOM01.GetActorType(akRef)
	actorSex  = DOM01.GetActorGender(akRef,actorType)
	;LogTrace("SetGender DOM gender actorType="+actorType+" actorSex="+actorSex)

	if actorSex == 0 ; Binary NPC
		actorBeVerb     = "is"
		actorPronoun    = "he"
		actorObjective  = "him"
		actorPossessive = "his"
	elseif actorSex == 1
		actorBeVerb     = "is"
		actorPronoun    = "she"
		actorObjective  = "her"
		actorPossessive = "her"
	elseif actorSex == 2 ; Creatures
		actorBeVerb     = "is"
		actorPronoun    = "he"
		actorObjective  = "him"
		actorPossessive = "his"
	elseif actorSex == 3
		actorBeVerb     = "is"
		actorPronoun    = "she"
		actorObjective  = "her"
		actorPossessive = "her"
	elseif actorSex == 4 || actorSex == 6 ; Non binary & other
		actorBeVerb     = "are"
		actorPronoun    = "they"
		actorObjective  = "them"
		actorPossessive = "their"
	else
		actorBeVerb     = "are"
		actorPronoun    = "they"
		actorObjective  = "them"
		actorPossessive = "their"
	endif
EndFunction

Function SetGenderByString(string str_gender)
	if str_gender == ""
		return
	endif
	actorType = DOM01.GetActorType(akRef)
	actorSex  = DOM01.GetActorGenderByString(akRef,str_gender,actorType)
	;LogTrace("SetGenderByString DOM gender actorType="+actorType+" actorSex="+actorSex)

	if actorSex == 0    ; Binary NPC
		actorBeVerb     = "is"
		actorPronoun    = "he"
		actorObjective  = "him"
		actorPossessive = "his"
	elseif actorSex == 1
		actorBeVerb     = "is"
		actorPronoun    = "she"
		actorObjective  = "her"
		actorPossessive = "her"
	elseif actorSex == 2 ; Creatures
		actorBeVerb     = "is"
		actorPronoun    = "he"
		actorObjective  = "him"
		actorPossessive = "his"
	elseif actorSex == 3
		actorBeVerb     = "is"
		actorPronoun    = "she"
		actorObjective  = "her"
		actorPossessive = "her"
	elseif actorSex == 4 || actorSex == 6 ; Non binary & other
		actorBeVerb     = "are"
		actorPronoun    = "they"
		actorObjective  = "them"
		actorPossessive = "their"
	else
		actorBeVerb     = "are"
		actorPronoun    = "they"
		actorObjective  = "them"
		actorPossessive = "their"
	endif
EndFunction

Function SetProperties(bool isSlave, bool playerOwned)
	akRef     = GetActorRef()
	actor_alias  = (self as ReferenceAlias) as DOM_Actor
	is_slave  = isSlave
	PlayerRef = Game.GetPlayer()
	name      = akRef.getDisplayName()
	;LogTrace("SetProperties() start mood="+mood)
	;LogTrace("SetProperties() mood="+mood)
	actorLevel      = akRef.GetLevel()
	;LogInfo("== Mind setup mood="+mood)
	SetGender()
	setTitleByType(isSlave)
	if isSlave
		int rank = akRef.GetFactionRank(DOM01.DOMActorFamilyHistory)
		if rank == 5 ; was freed by player
			akRef.RemoveFromFaction(DOM01.DOMActorFamilyHistory)
		endif
	endif
EndFunction

Function ClearValues()
	if akRef != None
		name = akRef.GetDisplayName()
	else
		name = ""
	endif
	__is_slave = true
	__is_freed_slave = false
	actor_owner = None
	actor_owner_title = ""
	__actor_owner_sex = -1
	ClearMemories()
	canChangeMood = true
	broken_time = 0.0
	timer_obedient = 0
	__is_love_interest = false
	mood_is_busy = false
	on_update = false
	on_update_gametime = false
	arousal_factor = 0.0
	__is_aroused_for = 0
	__is_enraptured_for = 0
	had_orgasm = false
	had_separate_orgasm = false
	had_handle_orgasm = false
	had_slso = false
	__drunk_level = 0
	blood_alcohol = 0.0
	blood_alcohol_time = 0.0
	blood_alcohol_last_time = 0.0
	blood_alcohol_start_level = 0.0
	intake_alcohol = 0.0
    intake_alcohol_time = 0.0 
    intake_alcohol_last_time = 0.0 
	intake_alcohol_start_level = 0.0
	drunk_passedout = false
	drugged_passedout = false
	BASE_Agreeableness = -1.0
	BASE_Boldness = -1.0
	BASE_Conscientiousness = -1.0
	BASE_Emotionality = -1.0
	BASE_Extraversion = -1.0
	BASE_Honesty = -1.0
	BASE_Openness = -1.0
	BASE_Sensuality = -1.0
	BASE_Smartness = -1.0
	BASE_Submissivity = -1.0
	BASE_Toughness = -1.0
	BASE_Wilfulness = -1.0
	BASE_Extraversion = -1.0
	personality_index = -1
	Sum_FACET = 0.0
	Sum_HEXACO = 0.0
	training_status = 0
	training_status_name = "freshly captured"
	bHasFought = false
	was_fighting = false
	was_allowed_toorgasm = true
	__was_fighting_for_player = true
	__was_respectful = true
	__is_walking_on_four = false
	was_silent = true
	promiseTimer = 0.0
	promiseOath = "nothing"
	promise_kept = 0
	int n = next_punishment_reason_slot.Length
	int i = 0
	while i < n
		_next_punishment_reason_slot[i] = 0
		i+=1
	endwhile
	end_punishment_on_next_tick = false
	whipping_active = false
	next_punishment_reason_nb = 0
	whipping_by_trainer = false
	punishing_trainee_or_trainer = false
	whipping_pain_damage = 0
	whip_pain_damage = 0
	slap_pain_damage = 0
	cane_pain_damage = 0
	whipping_reason = 0
	whipping_type = ""
	whipping_reason_name           = "no reason"
	current_punishment_reason = 0
	current_punishment_reason_name = "no reason"
	current_punishment_type = ""
	last_punishment_reason = 0
	__last_toldoff_reason = 0
	last_punishment_reason_name    = "no reason"
	__warn_punishment_reason = 0
	warn_punishment_reason_name    = "no reason"
	last_toldoff_reason_name    = "no reason"
	abuse_type = "physical"
	force_crying_as_punishment_reason = false
	timer_warned = 0
	reason_warned = -1
	n = next_praise_reason_slot.Length
	i = 0
	while i < n
		_next_praise_reason_slot[i] = 0
		i+=1
	endwhile
	next_praise_reason_nb = 0
	last_praise_reason = 0
	last_praise_reason_name = "no reason"
	__should_be_naked = false
	__should_wear_armor = true
	__should_hold_weapons = false
	__should_be_noorgasm = false
	__should_walk_on_four = false
	__should_be_respectful = false
	__should_be_silent = false
	__should_fight_for_player = false
	anger_factor = 0.0
	n = effect_kinks_slot.Length
	i = 0
	while i < n
		_effect_kinks_slot[i] = 0
		i+=1
	endwhile
	effect_kinks_nb = 0
	effect_kinks_max = 0.0
	effect_kinks_idx = 0
	n = known_kinks_slot.Length
	i = 0
	while i < n
		_known_kinks_slot[i] = 0
		i+=1
	endwhile
	known_kinks_nb = 0
	n = hidden_kinks_slot.Length
	i = 0
	while i < n
		_hidden_kinks_slot[i] = 0
		i+=1
	endwhile
	hidden_kinks_nb = -1
	before_clear_is_busy = false
EndFunction

Function SetLoveInterest()
	if is_player_actor
		is_love_interest = false
		return
	endif		
	if number_of_flatter > 0
		is_love_interest = true
		return
	endif
	if DOM01.DOMPlayerAlias.GetPlayerSex() != actorSex && !DOM01.oppositeSexToggle
		is_love_interest= false
		return
	endif
	if DOM01.DOMPlayerAlias.GetPlayerSex() == actorSex && !DOM01.sameSexToggle
		is_love_interest= false
		return
	endif
	is_love_interest = true
EndFunction

float default_aggression = 0.0
float default_confidence = 0.0
float default_assistance = 0.0
float default_morality   = 0.0

Function ReCheck()
	if __mood == "just_captured"
		CheckMoodFactions()
	else
		ResetMood()
	endif
	; Compute modifiers & update
	ResetModifiers()
	;PrintPersonality()

	;LogTrace("Check skills and training for backward compatibility")
	; Punishing slaves

	akRef.SetFactionRank(DOM01.DOMTrainSubmission, __submission as Int)
	akRef.SetFactionRank(DOM01.DOMTrainFear, __fear_training as Int)
	akRef.SetFactionRank(DOM01.DOMTrainHumiliation, __humiliation as Int)
	akRef.SetFactionRank(DOM01.DOMTrainAnger, __anger_training as Int)
	akRef.SetFactionRank(DOM01.DOMTrainResignation, __resignation as Int)
	akRef.SetFactionRank(DOM01.DOMTrainRespect, __respect_training as Int)

	akRef.SetFactionRank(DOM01.DOMTrainSex, __sex_training as Int)
	akRef.SetFactionRank(DOM01.DOMTrainAnal, __anal_training as Int)
	akRef.SetFactionRank(DOM01.DOMTrainVaginal, __vaginal_training as Int)
	akRef.SetFactionRank(DOM01.DOMTrainOral, __oral_training as Int)
	akRef.SetFactionRank(DOM01.DOMTrainPose, __pose_training as Int)
	akRef.SetFactionRank(DOM01.DOMTrainHouse, __house_training  as Int)
	akRef.SetFactionRank(DOM01.DOMTrainWorking, __work_training  as Int)
	akRef.SetFactionRank(DOM01.DOMTraumaInDays, __timer_for_broken  as Int)
	if drunk_level > 0
		akRef.SetFactionRank(DOM01.DOMDrunkLevel, drunk_level)
	else
		akRef.RemoveFromFaction(DOM01.DOMDrunkLevel)
	endif
	
	SetFactionRankFloat(akRef, DOM01.DOMTrainCombat, __combat_training)
	SetMoodFaction()
	SetBoolFaction(akRef, DOM01.DOMIsLoveInterest, __is_love_interest)
	SetBoolFaction(akRef, DOM01.DOMShouldBeRespectful, __should_be_respectful)
	SetBoolFaction(akRef, DOM01.DOMShouldFightForPlayer, __should_fight_for_player)
	SetBoolFaction(akRef, DOM01.DOMIsRespectful, __was_respectful)
	SetBoolFaction(akRef, DOM01.DOMShouldWalkOnFour, __should_walk_on_four)
	is_walking_on_four = __should_walk_on_four
	SetAllowGearFaction()
	CheckPotentialSlaverFaction()
EndFunction

Function SetPersonality(bool newActor)
	; -=TAK=- generate personality traits
	default_aggression = akRef.GetBaseActorValue("aggression")
	default_confidence = akRef.GetBaseActorValue("confidence")
	default_assistance = akRef.GetBaseActorValue("assistance")
	default_morality   = akRef.GetBaseActorValue("morality")
	if !is_player_actor
		akRef.SetActorValue("aggression", 0.0)
	endif
	
	; Personnality traits as described by the HEXACO model
	float[] TraitsArray  = DOM01.DOMGenerator.ReadBaseTraits(akRef)	
	SetBaseTraits(TraitsArray)

	TraitsArray  = DOM01.DOMGenerator.GetNPCTraits(akRef)	
	SetDefaultTraits(TraitsArray)

	; Recover training stats

	;PrintTrainingBefore("GetTrainingStatsFromFactionsOrRead",0.0,"")
	DOM01.DOMGenerator.GetTrainingStatsFromFactionsOrRead(akRef)
	;PrintTrainingAfter("GetTrainingStatsFromFactionsOrRead",0.0,"")
	;PrintTrainingBefore("GetTrainingStatsFromFactions",0.0,"")
	DOM01.DOMGenerator.GetTrainingStatsFromFactions(self)
	;PrintTrainingAfter("GetTrainingStatsFromFactions",0.0,"")
	
	;LogTrace("SetPersonality vaginal training="+vaginal_training)
	;LogTrace("SetPersonality oral training="+oral_training)
	;LogTrace("SetPersonality anal training="+anal_training)
	;LogTrace("SetPersonality sex training="+sex_training)
	; Recover life style orders
	LogTrace("SetPersonality is_slave="+is_slave+" newActor="+newActor+" should_wear_armor="+should_wear_armor)
	if is_slave
		if newActor
			__should_wear_armor       = true
		else
			__should_wear_armor       = akRef.IsInFaction(DOM01.DOMShouldWearArmor)
		endif
		__should_be_respectful    = akRef.IsInFaction(DOM01.DOMShouldBeRespectful)
		__should_walk_on_four     = akRef.IsInFaction(DOM01.DOMShouldWalkOnFour)
		__should_fight_for_player = akRef.IsInFaction(DOM01.DOMShouldFightForPlayer)
		__should_hold_weapons     = akRef.IsInFaction(DOM01.DOMShouldHoldWeapons)
		__should_be_naked         = akRef.IsInFaction(DOM01.DOMShouldBeNaked)
		__should_be_silent        = akRef.IsInFaction(DOM01.DOMShouldBeSilent)
		__should_be_noorgasm      = akRef.IsInFaction(DOM01.DOMShouldBeNoOrgasm)
		if !__should_hold_weapons
			UnequipHandheld(akRef)
		endif
	else
		__should_be_respectful    = true
		if !akRef.IsInFaction(DOM01.DOMShouldBeRespectful)
			akRef.AddToFaction(DOM01.DOMShouldBeRespectful)
		endif
		__should_fight_for_player = akRef.IsInFaction(DOM01.DOMShouldFightForPlayer)
		__should_walk_on_four     = false
		__should_hold_weapons     = true
		__should_wear_armor       = true
		__should_be_naked         = false
		if akRef.IsInFaction(DOM01.DOMShouldBeNaked)
			akRef.RemoveFromFaction(DOM01.DOMShouldBeNaked)
		endif
		__should_be_silent        = false
		if akRef.IsInFaction(DOM01.DOMShouldBeSilent)
			akRef.RemoveFromFaction(DOM01.DOMShouldBeSilent)
		endif
		__should_be_noorgasm      = false
	endif
	is_walking_on_four = __should_walk_on_four
	SetAllowGearFaction()
	
	; Correct values for backward compatibility
	if number_of_sex < number_of_rape 
		number_of_sex = number_of_rape
	endif

	; Virgin status
	int[] vstatus = DOM01.DOMGenerator.GetVirginStatus(akRef)
	SetVirginStatus(vstatus)

	if newActor
		IntegrateSexLabStats() ; Check sex stats according to Sexlab status
	endif
	ResetSexLabStats() ; Reset SexLab stats according to virginity status
	
	; Save outfit, if needed
	if !is_player_actor
		LogTrace("SetOldOutfit TransferOutfitIfSettings")
		actor_alias.SetOldOutfit(DOM01.DOMEquip.TransferOutfitIfSettings(akRef,false)) ; Only Transfer outfit according to toggles
		; Equip outfit once, if present
		;LogTrace("SetPersonality2 is_slave="+is_slave+" newActor="+newActor+" should_wear_armor="+should_wear_armor)
		DOM01.DOMEquip.EquipOutfit(akRef,false,false,true,false)  ; not naked, allow armor, no weapons
		; Equip rest of items
		actor_alias.SendOrderEquipInventoryQuiet(false) ; no anim
	endif
	;LogTrace("SetPersonality3 is_slave="+is_slave+" newActor="+newActor+" should_wear_armor="+should_wear_armor)
	SetPunishmentReasonsFromFactions()
	SetPraiseReasonsFromFactions()
	SetKinks(0)
	ReCheck()
	DOM01.DOMGenerator.SetMemories(self)
EndFunction

Function SetAllowGearFaction()
	; creatures and animals & naked actors
	if actor_alias.actorType != 0 || __should_be_naked
		DOM01.DOMEquip.SetAllowGearFaction(akRef,false,is_slave)
		return
	endif
	DOM01.DOMEquip.SetAllowGearFaction(akRef,true,is_slave)
EndFunction

bool Property is_initializing = false Auto Hidden
Function SetMindReady()
	is_initializing = false
	;LogTrace("SetMindReady() is_initializing="+is_initializing)
	actor_alias.SetMindReady()
EndFunction

Function SetMindBusy()
	is_initializing = true
	;LogTrace("SetMindBusy() is_initializing="+is_initializing)
	actor_alias.SetMindBusy()
EndFunction

Function ResetModifiers(bool doprint = false)
	; Honesty
	MOD_Humility = GetDefaultModifierHumility(1.0)		
	MOD_Sincerity = GetDefaultModifierSincerity(1.0)
	MOD_Modesty = GetDefaultModifierModesty(1.0)
	MOD_Insensitivity = getDefaultModifierInsensitivity(1.0)
	MOD_Greed = GetDefaultModifierGreed(1.0)
	MOD_Criminality = getDefaultModifierCriminality(1.0)
	MOD_Vaginal = GetDefaultModifierVaginal(1.0)
	; Emotionality
	MOD_Panic = GetDefaultModifierPanic(1.0)
	MOD_Fearfulness = GetDefaultModifierFearfulness(1.0)
	MOD_Sentimentality = GetDefaultModifierSentimentality(1.0)
	MOD_Impressionable = GetDefaultModifierImpressionable(1.0)
	MOD_Dependence = GetDefaultModifierDependence(1.0)
	MOD_Anxiety = GetDefaultModifierAnxiety(1.0)
	MOD_Intimidate = GetDefaultModifierIntimidate(1.0)
	; eXtraversion
	MOD_Liveliness = GetDefaultModifierLively(1.0)
	MOD_SelfEsteem = GetDefaultModifierSelfEsteem(1.0)
	MOD_Naivety = GetDefaultModifierNaivety(1.0)	
	MOD_Sociability = GetDefaultModifierSociability(1.0)
	MOD_Daring = GetDefaultModifierDaring(1.0)
	MOD_Ingenuity = GetDefaultModifierIngenuity(1.0)
	MOD_Oral = GetDefaultModifierOral(1.0)
	; Agreeableness
	MOD_Gentleness = GetDefaultModifierGentleness(1.0)
	MOD_Impatience = getDefaultModifierImpatience(1.0)
	MOD_Hope = GetDefaultModifierHope(1.0)
	MOD_Forgiveness = getDefaultModiferForgiveness(1.0)
	MOD_Empathy = GetDefaultModifierEmpathy(1.0)
	MOD_Resentment = GetDefaultModifierResentment(1.0)
	MOD_Anal = GetDefaultModifierAnal(1.0)
	; Conscientious
	MOD_Laborious = GetDefaultModifierLaborious(1.0)
	MOD_Diligent = GetDefaultModifierDiligent(1.0)
	MOD_Consideration = GetDefaultModifierConsideration(1.0)
	MOD_Perfectionism = GetDefaultModifierPerfectionism(1.0)
	MOD_Prudent = GetDefaultModifierPrudent(1.0)	
	MOD_Organized = GetDefaultModifierOrganized(1.0)
	MOD_Controller = GetDefaultModifierController(1.0)
	; Open-minded
	MOD_Authority = GetDefaultModifierAuthority(1.0)
	MOD_Rebellion = GetDefaultModifierRebellion(1.0)
	MOD_Flexibility = GetDefaultModifierFlexibility(1.0)
	MOD_Manipulation = GetDefaultModifierManipulation(1.0)
	MOD_Creativity = GetDefaultModifierCreativity(1.0)
	MOD_Discipline = GetDefaultModifierDiscipline(1.0)	
	MOD_Pretender = GetDefaultModifierPretender(1.0)
	; Physical and Physiological
	MOD_Orgasm = GetDefaultModifierOrgasm(1.0)
	MOD_Addict = GetDefaultModifierAddict(1.0)
	MOD_Combat = getDefaultModifierCombat(1.0)
	MOD_SumAll = GetDefaultModifiersSum()

	; update mind change mood parameters now
	registered_updates1 = 0x7fffffff
	registered_updates2 = 0x7fffffff
	UpdateRegistered()
	registered_updates1 = 0
	registered_updates2 = 0
EndFunction

Function PrintPersonality()
	if DOM01.debugMode == false
		return
	endif

	; Call traits set Function to force recompute modifiers
	float[] traits = new float[12]
	traits[0] = HEXACO_Honesty
	traits[1] = HEXACO_Emotionality
	traits[2] = HEXACO_eXtraversion
	traits[3] = HEXACO_Agreeableness
	traits[4] = HEXACO_Conscientiousness
	traits[5] = HEXACO_Openness
	
	traits[6] = FACET_Wilfulness
	traits[7] = FACET_Toughness
	traits[8] = FACET_Sensuality
	traits[9] = FACET_Submissivity
	traits[10]= FACET_Boldness
	traits[11]= FACET_Smartness


	actorBase abTarget = akRef.GetLeveledActorBase()
	int formID = Math.LogicalAnd(abTarget.GetFormID(), 0xFFFFFF)
	String IDstr = DOM_Util.ConvertIDToHex(formID)

	LogInfo(" Personality traits, facets and modifiers: id="+IDstr)
	LogInfo(" =====================================================")
	LogInfo(" Honesty            = "+HEXACO_Honesty +" / "+akRef.GetFactionRank(DOM01.DOMTraitHonesty))
	LogInfo(" Wilfulness         = "+FACET_Wilfulness +" / "+akRef.GetFactionRank(DOM01.DOMFacetWilfulness))
	LogInfo(" *+-- HUMILITY        [Wilfulness   ] [Toughness    ] {SUBMISSION      } = "+MOD_Humility*100.0) ;  +" / "+GetDefaultModifierHumility(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModHumility)+" / "+DOM01.DOMGenerator.GetDefaultModifierHumility(100.0,traits))
	LogInfo("  +-+ sincerity       [Toughness    ] [Agreeableness] {Pain eff        } = "+MOD_Sincerity*100.0) ;  +" / "+GetDefaultModifierSincerity(100.0))
	LogInfo("  ++- modesty         [Sensuality   ] [Emotionality ] {Love desire     } = "+MOD_Modesty*100.0) ;  +" / "+GetDefaultModifierModesty(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModModesty)+" / "+DOM01.DOMGenerator.GetDefaultModifierModesty(100.0,traits))
	LogInfo("  --+ INSENSITIVITY   [Submissivity ] [eXtraversion ] {ENFORCER        } = "+MOD_Insensitivity*100.0) ;  +" / "+GetDefaultModifierInsensitivity(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModInsensitivity)+" / "+DOM01.DOMGenerator.GetDefaultModifierInsensitivity(100.0,traits))
	LogInfo("  --- greed           [Boldness     ] [Conscientious] {Gifts eff       } = "+MOD_Greed*100.0) ;  +" / "+GetDefaultModifierGreed(100.0))
	LogInfo("  -+- criminality     [Smartness    ] [Open-minded  ] {Honesty var     } = "+MOD_Criminality*100.0) ;  +" / "+GetDefaultModifierCriminality(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModCriminality)+" / "+DOM01.DOMGenerator.GetDefaultModifierCriminality(100.0,traits))
	LogInfo("  +++ vaginal         [Sensual/Wil  ] [Submissivity ] {Vaginal sex     } = "+MOD_Vaginal*100.0) ;  +" / "+GetDefaultModifierVaginal(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModVaginal)+" / "+DOM01.DOMGenerator.GetDefaultModifierVaginal(100.0,traits))
	LogInfo(" Emotionality       = "+HEXACO_Emotionality +" / "+akRef.GetFactionRank(DOM01.DOMTraitEmotionality))
	LogInfo(" Toughness          = "+FACET_Toughness +" / "+akRef.GetFactionRank(DOM01.DOMFacetToughness))
	LogInfo("  +-- panicky         [Wilfulness   ] [Boldness     ] {Emotions trigger} = "+MOD_Panic*100.0) ;  +" / "+GetDefaultModifierPanic(100.0))
	LogInfo(" *+-+ FEARFULNESS     [Toughness    ] [eXtraversion ] {FEAR TRAINING   } = "+MOD_Fearfulness*100.0) ;  +" / "+GetDefaultModifierFearfulness(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModFearfulness)+" / "+DOM01.DOMGenerator.GetDefaultModifierFearfulness(100.0,traits))
	LogInfo("  +++ sentimentality  [Sensuality   ] [Smartness    ] {Emotionality var} = "+MOD_Sentimentality*100.0) ;  +" / "+GetDefaultModifierSentimentality(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModSentimentality)+" / "+DOM01.DOMGenerator.GetDefaultModifierSentimentality(100.0,traits))
	LogInfo("  ++- impressionable  [Submissivity ] [Open-minded  ] {Kink eff        } = "+MOD_Impressionable*100.0) ;  +" / "+GetDefaultModifierImpressionable(100.0))
	LogInfo("  +-+ dependence      [Boldness     ] [Agreeableness] {Loyal worship   } = "+MOD_Dependence*100.0) ;  +" / "+GetDefaultModifierDependence(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModDependence)+" / "+DOM01.DOMGenerator.GetDefaultModifierDependence(100.0,traits))
	LogInfo("  +++ anxiety         [Smartness    ] [Conscientious] {Sex eff         } = "+MOD_Anxiety*100.0) ;  +" / "+GetDefaultModifierAnxiety(100.0))
	LogInfo(" *++- INTIMIDATE      [Toughness    ] [Honesty      ] {PERSUADER       } = "+MOD_Intimidate*100.0) ;  +" / "+GetDefaultModifierIntimidate(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModIntimidate)+" / "+DOM01.DOMGenerator.GetDefaultModifierIntimidate(100.0,traits))
	LogInfo(" eXtraversion       = "+HEXACO_eXtraversion +" / "+akRef.GetFactionRank(DOM01.DOMTraitExtraversion))
	LogInfo(" Sensuality         = "+FACET_Sensuality +" / "+ akRef.GetFactionRank(DOM01.DOMFacetSensuality))
	LogInfo("  +-+ liveliness      [Wilfulness   ] [Agreeableness] {Rape eff        } = "+MOD_Liveliness*100.0) ;  +" / "+GetDefaultModifierLively(100.0))
	LogInfo("  ++- SELF-ESTEEM     [Toughness    ] [Honesty      ] {DEPRAVER        } = "+MOD_SelfEsteem*100.0) ;  +" / "+GetDefaultModifierSelfEsteem(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModSelfEsteem)+" / "+DOM01.DOMGenerator.GetDefaultModifierSelfEsteem(100.0,traits))
	LogInfo(" *-+- NAIVETY         [Sensuality   ] [Open-minded  ] {HUMILIATION     } = "+MOD_Naivety*100.0) ;  +" / "+GetDefaultModifierNaivety(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModNaivety)+" / "+DOM01.DOMGenerator.GetDefaultModifierNaivety(100.0,traits))
	LogInfo("  +++ sociability     [Submissivity ] [Boldness     ] {Feelings trigger} = "+MOD_Sociability*100.0) ;  +" / "+GetDefaultModifierSociability(100.0))
	LogInfo("  +++ daring          [Boldness     ] [Toughness    ] {Extraversion var} = "+MOD_Daring*100.0) ;  +" / "+GetDefaultModifierDaring(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModDaring)+" / "+DOM01.DOMGenerator.GetDefaultModifierDaring(100.0,traits))
	LogInfo("  --+ ingenuity       [Smartness    ] [Emotionality ] {Love fascination} = "+MOD_Ingenuity*100.0) ;  +" / "+GetDefaultModifierIngenuity(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModIngenuity)+" / "+DOM01.DOMGenerator.GetDefaultModifierIngenuity(100.0,traits))
	LogInfo("  -++ oral            [Sensual/Submi] [Conscientious] {Oral sex        } = "+MOD_Oral*100.0) ;  +" / "+GetDefaultModifierOral(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModOral)+" / "+DOM01.DOMGenerator.GetDefaultModifierOral(100.0,traits))
	LogInfo(" Agreeableness      = "+HEXACO_Agreeableness +" / "+akRef.GetFactionRank(DOM01.DOMTraitAgreeableness))
	LogInfo(" Submissivity       = "+FACET_Submissivity +" / "+akRef.GetFactionRank(DOM01.DOMFacetSubmissivity))
	LogInfo("  +-+ gentleness      [Wilfulness   ] [Honesty      ] {Loyal absolution} = "+MOD_Gentleness*100.0) ;  +" / "+GetDefaultModifierGentleness(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModGentleness)+" / "+DOM01.DOMGenerator.GetDefaultModifierGentleness(100.0,traits))
	LogInfo("  --+ impatience      [Toughness    ] [eXtraversion ] {Agreeableness vr} = "+MOD_Impatience*100.0) ;  +" / "+GetDefaultModifierImpatience(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModImpatience)+" / "+DOM01.DOMGenerator.getDefaultModifierImpatience(100.0,traits))
	LogInfo("  +++ hope            [Sensuality   ] [Wilfulness   ] {Comfort eff     } = "+MOD_Hope*100.0) ;  +" / "+GetDefaultModifierHope(100.0)) ;;; +" / "+GetModifierFromFaction(akRef,DOM01.DOMModHope)+" / "+DOM01.DOMGenerator.GetDefaultModifierHope(100.0,traits))
	LogInfo(" *+++ FORGIVENESS     [Submissivity ] [Emotionality ] {ANGER TRAINING  } = "+MOD_Forgiveness*100.0) ;  +" / "+getDefaultModiferForgiveness(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModForgiveness)+" / "+DOM01.DOMGenerator.getDefaultModiferForgiveness(100.0,traits))
	LogInfo("  +++ empathy         [Boldness     ] [Sensuality   ] {Friends eff     } = "+MOD_Empathy*100.0) ;  +" / "+GetDefaultModifierEmpathy(100.0))
	LogInfo("  -++ RESENTMENT      [Smartness    ] [Conscientious] {PREDATOR        } = "+MOD_Resentment*100.0) ;  +" / "+GetDefaultModifierResentment(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModResentment)+" / "+DOM01.DOMGenerator.GetDefaultModifierResentment(100.0,traits))
	LogInfo("  ++- anal            [Subm/Wil     ] [Open-minded  ] {Anal sex        } = "+MOD_Anal*100.0) ;  +" / "+GetDefaultModifierAnal(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModAnal)+" / "+DOM01.DOMGenerator.GetDefaultModifierAnal(100.0,traits))
	LogInfo(" Conscientious      = "+HEXACO_Conscientiousness +" / "+akRef.GetFactionRank(DOM01.DOMTraitConscientiousness))
	LogInfo(" Boldness           = "+FACET_Boldness +" / "+akRef.GetFactionRank(DOM01.DOMFacetBoldness))
	LogInfo("  +-- Laborious       [Wilfulness   ] [Smartness    ] {Scolding eff    } = "+MOD_Laborious*100.0) ;  +" / "+GetDefaultModifierLaborious(100.0))
	LogInfo("  ++- diligent        [Toughness    ] [Submissivity ] {Conscientious vr} = "+MOD_Diligent*100.0) ;  +" / "+GetDefaultModifierDiligent(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModDiligent)+" / "+DOM01.DOMGenerator.GetDefaultModifierDiligent(100.0,traits))
	LogInfo("  +++ consideration   [Sensuality   ] [Emotionality ] {Loyal devotion  } = "+MOD_Consideration*100.0) ;  +" / "+GetDefaultModifierConsideration(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModConsideration)+" / "+DOM01.DOMGenerator.GetDefaultModifierConsideration(100.0,traits))
	LogInfo("  +++ perfectionism   [Submissivity ] [eXtraversion ] {House training  } = "+MOD_Perfectionism*100.0) ;  +" / "+GetDefaultModifierPerfectionism(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModPerfectionism)+" / "+DOM01.DOMGenerator.GetDefaultModifierPerfectionism(100.0,traits))
	LogInfo(" *+-+ PRUDENT         [Boldness     ] [Agreeableness] {RESIGNATION     } = "+MOD_Prudent*100.0) ;  +" / "+GetDefaultModifierPrudent(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModPrudent)+" / "+DOM01.DOMGenerator.GetDefaultModifierPrudent(100.0,traits))
	LogInfo("  +-- organized       [Smartness    ] [Open-minded  ] {Praising eff    } = "+MOD_Organized*100.0) ;  +" / "+GetDefaultModifierOrganized(100.0))
	LogInfo("  +-- CONTROLLER      [Submissivity ] [Honesty      ] {SLAVER          } = "+MOD_Controller*100.0) ;  +" / "+GetDefaultModifierController(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModController)+" / "+DOM01.DOMGenerator.GetDefaultModifierController(100.0,traits))
	LogInfo(" Open-mindedness    = "+HEXACO_Openness +" / "+akRef.GetFactionRank(DOM01.DOMTraitOpenness))
	LogInfo(" Smartness          = "+FACET_Smartness +" / "+akRef.GetFactionRank(DOM01.DOMFacetSmartness))
	LogInfo("  --+ authority       [Wilfulness   ] [Conscientious] {Work training   } = "+MOD_Authority*100.0 +" / "+GetDefaultModifierAuthority(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModAuthority)+" / "+DOM01.DOMGenerator.GetDefaultModifierAuthority(100.0,traits))
	LogInfo("  +++ rebellion       [Toughness    ] [Wilfulness   ] {Resilience      } = "+MOD_Rebellion*100.0  +" / "+GetDefaultModifierRebellion(100.0))
	LogInfo("  +++ flexibility     [Sensuality   ] [Agreeableness] {Pose training   } = "+MOD_Flexibility*100.0  +" / "+GetDefaultModifierFlexibility(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModFlexibility)+" / "+DOM01.DOMGenerator.GetDefaultModifierFlexibility(100.0,traits))
	LogInfo("  -++ manipulation    [Submissivity ] [Emotionality ] {Openness var    } = "+MOD_Manipulation*100.0  +" / "+GetDefaultModifierManipulation(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModManipulation)+" / "+DOM01.DOMGenerator.GetDefaultModifierManipulation(100.0,traits))
	LogInfo("  +++ creativity      [Boldness     ] [Sensuality   ] {Love admiration } = "+MOD_Creativity*100.0  +" / "+GetDefaultModifierCreativity(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModCreativity)+" / "+DOM01.DOMGenerator.GetDefaultModifierCreativity(100.0,traits))
	LogInfo(" *--+ DISCIPLINE      [Smartness    ] [eXtraversion ] {RESPECT TRAINING} = "+MOD_Discipline*100.0  +" / "+GetDefaultModifierDiscipline(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModDiscipline)+" / "+DOM01.DOMGenerator.GetDefaultModifierDiscipline(100.0,traits))
	LogInfo(" *++- PRETENDER       [Smartness    ] [Honesty      ] {DECEIVER        } = "+MOD_Pretender*100.0  +" / "+GetDefaultModifierPretender(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModPretender)+" / "+DOM01.DOMGenerator.GetDefaultModifierPretender(100.0,traits))
	LogInfo(" Purely Physical and Physiological:")
	LogInfo("  +-+ Orgasm          [Sensual/Tough] [Boldness     ] {Orgasm chance   } = "+MOD_Orgasm*100.0  +" / "+GetDefaultModifierOrgasm(100.0))
	LogInfo("  --- Addict          [Honest/Agreea] [Conscientious] {Addicted chance } = "+MOD_Addict*100.0  +" / "+GetDefaultModifierAddict(100.0))
	LogInfo("  +++ Combat          [Bold/Wilful  ] [Smartness    ] {Combat training } = "+MOD_Combat*100.0  +" / "+GetDefaultModifierCombat(100.0)+" / "+GetModifierFromFaction(akRef,DOM01.DOMModCombat)+" / "+DOM01.DOMGenerator.getDefaultModifierCombat(100.0,traits))
	LogInfo(" Sum of 6 main modifiers:")
	LogInfo("  *** Sum             [             ] [             ] {All abuse eff   } = "+MOD_SumAll/6.0*100.0  +" / "+GetDefaultModifiersSum()/6.0*100.0)
EndFunction

bool before_clear_is_busy = false
Event BeforeClear()
	if akRef == NONE
		return
	endif
	before_clear_is_busy = true
	LogTrace("BeforeClear start IsDead="+akRef.IsDead())
	should_fight_for_player = false
	UnregisterForUpdate()
	UnregisterForUpdateGameTime()
	if !is_player_actor
		UnregisterCombatEvents()
	endif
	UnRegisterModEvents()
	if akRef.IsInFaction(DOM01.DOMActorInTransfer)
		if DOM01.DOMGenerator.writeJSONTransfer
			DOM01.DOMGenerator.WriteJSON(actor_alias)
		endif
	elseif DOM01.DOMGenerator.writeJSONRelease
		DOM01.DOMGenerator.WriteJSON(actor_alias)
	endif
	MakeSober()
	DOM01.DOMSexlab.HandleArousalBeforeClear(akRef,actorSex)

	if __is_freed_slave
		akRef.SetFactionRank(DOM01.DOMHistoryFaction,2) ; previous player's slave being freed
		DOM01.DOMPAH.SetHasBeenPlayerSlaveFaction(akRef,1)
		akRef.SetFactionRank(DOM01.DOMActorFamilyHistory, 5) ; was freed by player
	elseif is_slave
		akRef.SetFactionRank(DOM01.DOMHistoryFaction,1) ; previous player's slave
		DOM01.DOMPAH.SetHasBeenPlayerSlaveFaction(akRef,1)
	else ; slaver
		int rank = akRef.GetFactionRank(DOM01.DOMHistoryFaction)
		if rank > 0 && rank < 3
			akRef.SetFactionRank(DOM01.DOMHistoryFaction,3) ; previous player's slaver and slave before that
			DOM01.DOMPAH.SetHasBeenPlayerSlaveFaction(akRef,1)
		else
			akRef.SetFactionRank(DOM01.DOMHistoryFaction,4) ; previous player's slaver
		endif
	endif
	;akRef.RemoveFromFaction(DOM01.DOMShouldBeRespectful)
	;akRef.RemoveFromFaction(DOM01.DOMShouldWalkOnFour)
	;akRef.RemoveFromFaction(DOM01.DOMShouldFightForPlayer)
	;akRef.RemoveFromFaction(DOM01.DOMShouldBeNaked)
	;akRef.RemoveFromFaction(DOM01.DOMShouldBeSilent)
	;akRef.RemoveFromFaction(DOM01.DOMShouldBeNoOrgasm)
	;akRef.RemoveFromFaction(DOM01.DOMIsWalkingOnFour)
	DOM01.DOMPAH.SetTrainingFactionsToPAH(akRef)
	
	if !is_player_actor
		akRef.SetActorValue("assistance", default_assistance)
		akRef.SetActorValue("confidence", default_confidence)
		akRef.SetActorValue("morality",   default_morality)
		
		if default_aggression > 1.0
			akRef.SetActorValue("aggression", 1.0)
		else
			akRef.SetActorValue("aggression", 0.0)
		endif
	endif
	
	ClearExpression()
	LogTrace("BeforeClear end mood="+mood)
	canChangeMood = false
EndEvent

Function SetDisplayName(string newName)
	name = newName
EndFunction

String Function getName()
	return name
EndFunction

Function setTitle(string newTitle = "")
	if newTitle != ""
		int l = StringUtil.GetLength(newTitle)
		l -= 1
		if StringUtil.GetNthChar(newTitle,l) == " "
			title = newTitle
		else
			title = newTitle+" "
		endif
		return
	endif
	setTitleByType(is_slave)
EndFunction

Function setTitleByType(bool isSlave)
	if isSlave
		if actor_alias.is_trainer
			if actorSex == 0
				title = "Henchman "
			elseif actorSex == 1
				title = "Henchwench "
			else
				title = "Henchperson "
			endif
		else
			title = ""
		endif
	elseif actorSex == 0 || actorSex == 2
		title = "Master "
	elseif actorSex == 1 || actorSex == 3
		title = "Mistress "
	elseif (actorSex %2) == 0
		title = "Mixter "
	else
		title = "Mixtress "
	endif
EndFunction

String Function getTitle()
	return title
EndFunction

; ### Set and check moods

Function SetMoodJustCaptured()
	canChangeMood = true
	mood = "just_captured"
EndFunction

Function SetMoodReleased(bool is_freed)
	;LogTrace("Actor is released "+name+" is_slave="+is_slave+" is_freed="+is_freed)
	is_freed_slave = is_freed
	UpdateRegistered()
	canChangeMood = true
	ChooseMoodSpontaneous(1.0)
	SetRelationshipToPlayer() ; just to make sure rank is updated
	SetRelationshipReleased()
EndFunction

Function SetRelationshipReleased()
	int rank = akRef.getRelationshipRank(PlayerRef)
	if IsInLove() && rank <= 4
		akRef.setRelationshipRank(PlayerRef, 4)
	elseif (IsHappy() || IsDevoted()) && rank <= 3
		akRef.setRelationshipRank(PlayerRef, 3)
	elseif IsOkayWithPlayer() && rank <= 2
		akRef.setRelationshipRank(PlayerRef, 2)
	elseif IsBrokenToObey() && rank <= 1
		akRef.setRelationshipRank(PlayerRef, 1)
	else
		akRef.setRelationshipRank(PlayerRef, 0)
	endif
EndFunction

Function CheckMoodFactions()
	LogTrace("CheckMoodFactions mood="+__mood)
	if akRef.IsInFaction(DOM01.DOMMoodJustCaptured) && __mood != "just_captured"
		LogTrace("CheckMoodFactions remove from faction DOMMoodJustCaptured with mood="+__mood)
		akRef.RemoveFromFaction(DOM01.DOMMoodJustCaptured)
	endif
	if akRef.IsInFaction(DOM01.DOMMoodAngry) && __mood != "angry" && __mood != "defiant" && __mood != "jealous"
		LogTrace("CheckMoodFactions remove from faction DOMMoodAngry with mood="+__mood)
		akRef.RemoveFromFaction(DOM01.DOMMoodAngry)
	endif
	if akRef.IsInFaction(DOM01.DOMMoodAfraid) && __mood != "afraid" && __mood != "terrified" && __mood != "scared"
		LogTrace("CheckMoodFactions remove from faction DOMMoodAfraid with mood="+__mood)
		akRef.RemoveFromFaction(DOM01.DOMMoodAfraid)
	endif
	if akRef.IsInFaction(DOM01.DOMMoodAshamed) && __mood != "ashamed" && __mood != "proud" && __mood != "insecure"
		LogTrace("CheckMoodFactions remove from faction DOMMoodAshamed with mood="+__mood)
		akRef.RemoveFromFaction(DOM01.DOMMoodAshamed)
	endif
	if akRef.IsInFaction(DOM01.DOMMoodSad) && __mood != "sad" && __mood != "crushed" && __mood != "depressed"
		LogTrace("CheckMoodFactions remove from faction DOMMoodSad with mood="+__mood)
		akRef.RemoveFromFaction(DOM01.DOMMoodSad)
	endif
	if akRef.IsInFaction(DOM01.DOMMoodShock) && __mood != "shock"
		LogTrace("CheckMoodFactions remove from faction DOMMoodShock with mood="+__mood)
		akRef.RemoveFromFaction(DOM01.DOMMoodShock)
	endif
	if akRef.IsInFaction(DOM01.DOMMoodBroken) && __mood != "broken"
		LogTrace("CheckMoodFactions remove from faction DOMMoodBroken with mood="+__mood)
		akRef.RemoveFromFaction(DOM01.DOMMoodBroken)
	endif
	if akRef.IsInFaction(DOM01.DOMMoodLoyal) && __mood != "loyal"
		LogTrace("CheckMoodFactions remove from faction DOMMoodLoyal with mood="+__mood)
		akRef.RemoveFromFaction(DOM01.DOMMoodLoyal)
	endif
	if akRef.IsInFaction(DOM01.DOMMoodInlove) && __mood != "inlove" && __mood != "depressed" && __mood != "jealous" && __mood != "insecure"
		LogTrace("CheckMoodFactions remove from faction DOMMoodInlove with mood="+__mood)
		akRef.RemoveFromFaction(DOM01.DOMMoodInlove)
	endif
	if akRef.IsInFaction(DOM01.DOMMoodHappy) && __mood != "happy" && __mood != "fine"
		LogTrace("CheckMoodFactions remove from faction DOMMoodHappy with mood="+__mood)
		akRef.RemoveFromFaction(DOM01.DOMMoodHappy)
	endif
	if akRef.IsInFaction(DOM01.DOMMoodNeutral) && __mood != "neutral"
		LogTrace("CheckMoodFactions remove from faction DOMMoodNeutral with mood="+__mood)
		akRef.RemoveFromFaction(DOM01.DOMMoodNeutral)
	endif

	if __mood == "just_captured"
		akRef.SetFactionRank(DOM01.DOMMoodJustCaptured,1)
	endif
	if __mood == "angry"
		akRef.SetFactionRank(DOM01.DOMMoodAngry,1)
	endif
	if __mood == "defiant"
		akRef.SetFactionRank(DOM01.DOMMoodAngry,2)
	endif
	if __mood == "jealous"
		akRef.SetFactionRank(DOM01.DOMMoodAngry,3)
		akRef.SetFactionRank(DOM01.DOMMoodInlove,3)
	endif
	if __mood == "afraid"
		akRef.SetFactionRank(DOM01.DOMMoodAfraid,1)
	endif
	if __mood == "terrified"
		akRef.SetFactionRank(DOM01.DOMMoodAfraid,2)
	endif
	if __mood == "scared"
		akRef.SetFactionRank(DOM01.DOMMoodAfraid,3)
	endif
	if __mood == "ashamed"
		akRef.SetFactionRank(DOM01.DOMMoodAshamed,1)
	endif
	if __mood == "proud"
		akRef.SetFactionRank(DOM01.DOMMoodAshamed,2)
	endif
	if __mood == "insecure"
		akRef.SetFactionRank(DOM01.DOMMoodAshamed,3)
		akRef.SetFactionRank(DOM01.DOMMoodInlove,4)
	endif
	if __mood == "sad"
		akRef.SetFactionRank(DOM01.DOMMoodSad,1)
	endif
	if __mood == "crushed"
		akRef.SetFactionRank(DOM01.DOMMoodSad,2)
	endif
	if __mood == "depressed"
		akRef.SetFactionRank(DOM01.DOMMoodSad,3)
		akRef.SetFactionRank(DOM01.DOMMoodInlove,2)
	endif
	if __mood == "shock"
		akRef.SetFactionRank(DOM01.DOMMoodShock,1)
	endif
	if __mood == "broken"
		akRef.SetFactionRank(DOM01.DOMMoodBroken,1)
	endif
	if __mood == "loyal"
		akRef.SetFactionRank(DOM01.DOMMoodLoyal,1)
	endif
	if __mood == "inlove"
		akRef.SetFactionRank(DOM01.DOMMoodInlove,1)
	endif
	if __mood == "fine"
		akRef.SetFactionRank(DOM01.DOMMoodHappy,1)
	endif
	if __mood == "happy"
		akRef.SetFactionRank(DOM01.DOMMoodHappy,2)
	endif
	if __mood == "neutral"
		akRef.SetFactionRank(DOM01.DOMMoodNeutral,1)
	endif
EndFunction

Function SetMoodFaction()
	if __mood == "just_captured"
		akRef.SetFactionRank(DOM01.DOMMoodJustCaptured,1)
	elseif __mood == "angry"
		akRef.SetFactionRank(DOM01.DOMMoodAngry,1)
	elseif __mood == "defiant"
		akRef.SetFactionRank(DOM01.DOMMoodAngry,2)
	elseif __mood == "jealous"
		akRef.SetFactionRank(DOM01.DOMMoodAngry,3)
		akRef.SetFactionRank(DOM01.DOMMoodInlove,3)
	elseif __mood == "afraid"
		akRef.SetFactionRank(DOM01.DOMMoodAfraid,1)
	elseif __mood == "terrified"
		akRef.SetFactionRank(DOM01.DOMMoodAfraid,2)
	elseif __mood == "scared"
		akRef.SetFactionRank(DOM01.DOMMoodAfraid,3)
	elseif __mood == "ashamed"
		akRef.SetFactionRank(DOM01.DOMMoodAshamed,1)
	elseif __mood == "proud"
		akRef.SetFactionRank(DOM01.DOMMoodAshamed,2)
	elseif __mood == "insecure"
		akRef.SetFactionRank(DOM01.DOMMoodAshamed,3)
		akRef.SetFactionRank(DOM01.DOMMoodInlove,4)
	elseif __mood == "sad"
		akRef.SetFactionRank(DOM01.DOMMoodSad,1)
	elseif __mood == "crushed"
		akRef.SetFactionRank(DOM01.DOMMoodSad,2)
	elseif __mood == "depressed"
		akRef.SetFactionRank(DOM01.DOMMoodSad,3)
		akRef.SetFactionRank(DOM01.DOMMoodInlove,2)
	elseif __mood == "shock"
		akRef.SetFactionRank(DOM01.DOMMoodShock,1)
	elseif __mood == "broken"
		akRef.SetFactionRank(DOM01.DOMMoodBroken,1)
	elseif __mood == "loyal"
		akRef.SetFactionRank(DOM01.DOMMoodLoyal,1)
	elseif __mood == "inlove"
		akRef.SetFactionRank(DOM01.DOMMoodInlove,1)
	elseif __mood == "fine"
		akRef.SetFactionRank(DOM01.DOMMoodHappy,1)
	elseif __mood == "happy"
		akRef.SetFactionRank(DOM01.DOMMoodHappy,2)
	elseif __mood == "charmed"
		akRef.SetFactionRank(DOM01.DOMMoodHappy,3)
		akRef.SetFactionRank(DOM01.DOMMoodInlove,0)
	elseif __mood == "neutral"
		akRef.SetFactionRank(DOM01.DOMMoodNeutral,1)
	endif
EndFunction

string Function GetMoodByFaction()
	if  akRef.IsInFaction(DOM01.DOMMoodJustCaptured)
		return "just_captured"
	elseif akRef.IsInFaction(DOM01.DOMMoodAngry)
		int rank = akRef.GetFactionRank(DOM01.DOMMoodAngry)
		if rank == 1
			return "angry"
		elseif rank == 2
			return "defiant"
		else
			return "jealous"
		endif
	elseif akRef.IsInFaction(DOM01.DOMMoodAfraid)
		int rank = akRef.GetFactionRank(DOM01.DOMMoodAfraid)
		if rank == 1
			return "afraid"
		elseif rank == 2
			return "terrified"
		elseif rank == 3
			return "scared"
		endif
	elseif akRef.IsInFaction(DOM01.DOMMoodAshamed)
		int rank = akRef.GetFactionRank(DOM01.DOMMoodAshamed)
		if rank == 1
			return "ashamed"
		elseif rank == 2
			return "proud"
		else
			return "insecure"
		endif
	elseif akRef.IsInFaction(DOM01.DOMMoodSad)
		int rank = akRef.GetFactionRank(DOM01.DOMMoodSad)
		if rank == 1
			return "sad"
		elseif rank == 2
			return "crushed"
		else
			return "depressed"
		endif
	elseif akRef.IsInFaction(DOM01.DOMMoodShock)
		return "shock"
	elseif akRef.IsInFaction(DOM01.DOMMoodBroken)
		return "broken"
	elseif akRef.IsInFaction(DOM01.DOMMoodLoyal)
		return "loyal"
	elseif akRef.IsInFaction(DOM01.DOMMoodHappy)
		int rank = akRef.GetFactionRank(DOM01.DOMMoodHappy)
		if rank == 1
			return "fine"
		elseif rank == 2
			return "happy"
		else
			return "charmed"
		endif
	elseif akRef.IsInFaction(DOM01.DOMMoodInlove)
		return "inlove"
	elseif akRef.IsInFaction(DOM01.DOMMoodNeutral)
		return "neutral"
	endif
	return ""
EndFunction

Function SetExpressionByMood()
	ClearExpression()
EndFunction

Function SetRelationshipToPlayer()
EndFunction

int Function GetMoodIndex()
	return 0 ; "empty_minded"
EndFunction

; ### Mood definitions ###

Auto State empty_minded
	Function StartMood()
		mood_swing_max = 2000
		LogTrace("mood=empty_minded start "+mood_swing_ticks+"/"+mood_swing_max)
		SetExpressionByMood()
	EndFunction

	Function EndMood()
		ClearExpression()
	EndFunction
	
	Function ChooseIdle()
	EndFunction

	Event OnToldOff(int ireason)
	EndEvent

	bool Function IsWillingToObey()
		return false
	EndFunction
	
	bool Function IsObedient()
		return false
	EndFunction

    string Function GetMoodName()
		return "empty minded"
	EndFunction
EndState

State just_captured
	Function StartMood()
		canChangeMood = false
		mood_swing_max = 2000
		LogTrace("mood=just_captured start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" was just captured")
		akRef.SetFactionRank(DOM01.DOMMoodJustCaptured,1)
		;akRef.SetFactionRank(DOM01.DOMMoodAfraid,1)
		;actor_alias.Anim_BleedOutStart()
		SetRelationshipToPlayer()
		SetExpressionByMood()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(12,80) ; Mood surprise expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodJustCaptured)
		;akRef.RemoveFromFaction(DOM01.DOMMoodAfraid)
	EndFunction
	
	Function ChooseIdle()
	EndFunction

	Event OnToldOff(int ireason)
	EndEvent

	bool Function IsScaredToObey()
		return true
	EndFunction

	bool Function IsWillingToObey()
		return true
	EndFunction

	bool Function IsShocked()
		return true
	EndFunction

    string Function GetMoodName()
		return "recently captured"
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "a freshly captured "
	EndFunction

	int Function GetMoodIndex()
		return 1 ; "just_captured"
	EndFunction

	Function SetRelationshipToPlayer()
		if akRef.GetRelationshipRank(PlayerRef) > -2
			akRef.SetRelationshipRank(PlayerRef, -2)
		endif
	EndFunction
EndState

State angry
	Function StartMood()
		LogTrace("mood=angry start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" "+actorBeVerb+" getting angry")
		akRef.SetFactionRank(DOM01.DOMMoodAngry,1)
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(8,100) ; Mood anger expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodAngry)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if !MakeRunAway()
			if !RecoverFrom()
				SetExpressionByMood()
				actor_alias.TryRemoveTears(2)
				ChooseMoodSpontaneousOnTick(0.1)
			endif
		endif
	EndFunction

	Function OnMoodUpdate()
		if !actor_alias.is_moving && RandomFloat() < 0.05
			ChooseIdle()
		endif
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if MakeMoodAfraid(0.25)
			;SetMoodAfraid()
		elseif MakeMoodSad(0.15)
			;SetMoodSad()
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndPunishment(Float severity)
		; extra guilt training
		TrainAnger(severity * 0.1*MOD_Gentleness)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if had_orgasm && MakeMoodAshamed(1.0)
			;SetMoodAshamed()
		elseif __is_aroused_for > 0 && MakeMoodAshamed(0.5)
			;SetMoodAshamed()
		elseif MakeMoodAshamed(0.25)
			;SetMoodAshamed()
		elseif !(__is_aroused_for > 0) && MakeMoodSad(0.15)
			;SetMoodSad()
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		float chance = __chance_recover_from_angry
		if whipping_active
			chance = chance*2.0
		endif
		if RandomFloat() < chance
			ChooseMoodChange()
			return true
		endif
		return false
	EndFunction
	
	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		if is_anal
			return 1.6*MOD_Anxiety
		endif
		return MOD_Anxiety
	EndFunction

	float Function getPainMultiplier()
		return 1.5*MOD_Sincerity
	EndFunction
	
	float Function getScoldMultiplier()
		return 0.5*MOD_Laborious
	EndFunction

	float Function getPraiseMultiplier()
		return 0.5*MOD_Organized
	EndFunction

	float Function getFeelingMultiplier()
		return 0.5*MOD_Sociability ; angry no thoughts
	EndFunction

	float Function getEmotionMultiplier() 
		return 1.5*MOD_Panic ; angry reacts fast
	EndFunction

	Float Function RunAwayMoodBase()
		return 0.75
	EndFunction

	Float Function CallForHelpMoodBase()
		return 1.0
	EndFunction
	
	Float Function StopWaitingMoodBase()
		return 0.5-anger_training / 200.0
	EndFunction

	Float Function BreakRestraintMoodBase()
		return 0.7
	EndFunction

	Float Function StopOrderMoodBase(float training)
		return (0.5-( training / 200.0 ))+(0.5-( anger_training / 200.0 ))
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; Slave is angry
		if RandomFloat() < MOD_Forgiveness && RandomFloat()*100.0 > respect_training
			actor_alias.Anim_AggressiveGesture()
			was_respectful = false
			SetNextPunishmentReasonSilent(13) ; "being disrespectful"
		elseif RandomFloat() < MOD_Resentment
			actor_alias.Anim_CrossArms()
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction
	
	Function ChooseTopic()
		bool not_respectful = IsNotRespectful(1.5)
		if not_respectful
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodAngry,PlayerRef)
		else
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodAngryRespectful,PlayerRef)
		endif
	EndFunction

	Event OnToldOff(int ireason)
		ChooseMoodSpontaneous(0.1)
		ChooseIdle()
	EndEvent

	bool Function IsObedient()
		if timer_obedient > 0 || RandomFloat() < MOD_Authority || RandomFloat()*100.0 < anger_training
			return true
		endif
		return false
	EndFunction

	bool Function IsAngry()
		return true
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "an angry "
    EndFunction
	
	int Function GetMoodIndex()
		return 2 ; "angry"
	EndFunction

	Function SetRelationshipToPlayer()
		if akRef.getRelationshipRank(PlayerRef) > -(3)
			akRef.setRelationshipRank(PlayerRef, akRef.getRelationshipRank(PlayerRef) - 1)
		endif
	EndFunction
EndState

;### Fear states: 1 afraid = yelling for help, 2 terrified = frozen paralyzed, 3 scared = obedient ### ###

State afraid
	Function StartMood()
		LogTrace("mood=afraid start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" "+actorBeVerb+" afraid")
		akRef.SetFactionRank(DOM01.DOMMoodAfraid,1)
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(9,80) ; Mood fear expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodAfraid)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if !MakeRunAway()
			if !RecoverFrom()
				SetExpressionByMood()
				TryFearTears()
				ChooseMoodSpontaneousOnTick(0.1)
			endif
		endif
	EndFunction

	Function OnMoodUpdate()
		if !actor_alias.is_moving && RandomFloat() < 0.05
			ChooseIdle()
		endif
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.1)
			mood = "shock"
		elseif RandomFloat() < (__chance_broken * 0.05)
			mood = "broken"
		elseif MakeMoodSad(0.1)
			;SetMoodSad()
		elseif MakeMoodAshamed(0.2)
			;SetMoodAshamed()
		elseif MakeMoodAngry(0.25)
			;SetMoodAngry()
		else
			ChooseIdle()
		endif
	EndEvent
	
	Event OnEndPunishment(Float severity)
		; extra fear and anger training
		TrainAnger(severity * 0.05)
		TrainFear(severity * 0.05)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if RandomFloat() < (__chance_shock * 0.1)
			mood = "shock"
			return
		endif
		if had_orgasm && MakeMoodAshamed(1.0)
			;SetMoodAshamed()
		elseif __is_aroused_for > 0 && MakeMoodAshamed(0.5)
			;SetMoodAshamed()
		elseif MakeMoodAshamed(0.25)
			;SetMoodAshamed()
		elseif !(__is_aroused_for > 0) && MakeMoodSad(0.25)
			;SetMoodSad()
		elseif MakeMoodAngry(0.25)
			;SetMoodAngry()
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		Float chance = __chance_recover_from_afraid*__chance_recently_punished_inverted
		;LogTrace("recover afraid chance="+chance)
		if RandomFloat() < chance
			ChooseMoodChange()
			return true
		endif
		return false
	EndFunction

	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		if is_vaginal
			return 1.6*MOD_Anxiety
		endif
		return MOD_Anxiety
	EndFunction

	float Function getPainMultiplier()
		return 1.2*MOD_Sincerity
	EndFunction

	float Function getRapeMultiplier()
		return 0.8*MOD_Liveliness
	EndFunction
	
	float Function getFeelingMultiplier() ; How much this mood affects emotions wrt training
		return 0.25*MOD_Sociability ; afraid, fear active mood dominated by emotions
	EndFunction

	float Function getEmotionMultiplier() ; How much this mood affects emotions wrt training
		return 1.75*MOD_Panic ; afraid yelling for help doesn't care about feelings, just emotions
	EndFunction

	Float Function RunAwayMoodBase()
		return 0.6
	EndFunction
	
	Float Function CallForHelpMoodBase()
		return 1.0
	EndFunction

	Float Function StopWaitingMoodBase()
		return 0.5-fear_training / 200.0
	EndFunction

	Float Function BreakRestraintMoodBase()
		return 0.65
	EndFunction

	Float Function StopOrderMoodBase(float training)
		return (0.5-( training / 200.0 ))+(0.5-( fear_training / 200.0 ))
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; Slave is afraid
		if RandomFloat() < MOD_Fearfulness
			actor_alias.Anim_Nervous()
		elseif RandomFloat() < MOD_Humility
			actor_alias.Anim_PleaseStop()
			SetNextPunishmentReasonSilent(1) ; "begging to stop"
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction
	
	Function ChooseTopic()
		bool not_respectful = IsNotRespectful(1.2)
		if not_respectful
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodAfraid,PlayerRef)
		else
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodAfraidRespectful,PlayerRef)
		endif
	EndFunction

	bool Function IsScaredToObey()
		return true
	EndFunction
	
	bool Function IsObedient()
		;*ogTrace("IsObedient mood="+mood+" timer_obedient="+timer_obedient+" MOD_Fearfulness="+MOD_Fearfulness+" fear_training="+fear_training)
		if timer_obedient > 0 || RandomFloat() < MOD_Fearfulness || RandomFloat()*100.0 < fear_training
			;*ogTrace("IsObedient true")
			return true
		endif
		;*ogTrace("IsObedient false")
		return false
	EndFunction

	bool Function IsAfraid()
		return true
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "a fearful "
    EndFunction

	int Function GetMoodIndex()
		return 3 ; "afraid"
	EndFunction

	Function SetRelationshipToPlayer()
		if akRef.getRelationshipRank(PlayerRef) > -(2)
			akRef.setRelationshipRank(PlayerRef, akRef.getRelationshipRank(PlayerRef) - 1)
		endif
	EndFunction
EndState

state terrified 
	Function StartMood()
		LogTrace("mood=terrified start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" "+actorBeVerb+" terrified")
		akRef.SetFactionRank(DOM01.DOMMoodAfraid, 2)
		actor_alias.TurnOffCrimeFaction()
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(9,100) ; Mood fear expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodAfraid)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if !RecoverFrom()
			SetExpressionByMood()
			TrySadnessTears()
			ChooseMoodSpontaneousOnTick(0.1)
		endif
	EndFunction

	Function OnMoodUpdate()
		if !actor_alias.is_moving && RandomFloat() < 0.05
			ChooseIdle()
		endif
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.3)
			mood = "shock"
		elseif RandomFloat() < (__chance_broken * 0.05)
			mood = "broken"
		elseif MakeMoodSad(0.2)
			;SetMoodSad()
		elseif MakeMoodAshamed(0.75)
			;SetMoodAshamed()
		elseif RandomFloat() < 0.25 && RandomFloat() < MOD_Prudent
			MakeCry()
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndPunishment(Float severity)
		; extra fear and resignation training
		TrainFear(severity * 0.05)
		TrainResignation(severity * 0.05)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if RandomFloat() < (__chance_shock * 0.4)
			mood = "shock"
			return
		endif
		if had_orgasm && MakeMoodAshamed(1.0)
			;SetMoodAshamed()
		elseif __is_aroused_for > 0 && MakeMoodAshamed(1.0)
			;SetMoodAshamed()
		elseif MakeMoodAshamed(0.75)
			;SetMoodAshamed()
		elseif !(__is_aroused_for > 0) && MakeMoodSad(0.5)
			;SetMoodSad()
		elseif RandomFloat() < 0.25 && RandomFloat() < MOD_Prudent
			MakeCry()
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		Float chance = __chance_recover_from_afraid*__chance_recently_punished_inverted
		;LogTrace("recover terrified chance="+chance)
		if RandomFloat() < chance
			ChooseMoodChange()
			return true
		endif
		return false
	EndFunction
	
	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		if is_vaginal
			return 1.6*MOD_Anxiety
		endif
		return MOD_Anxiety
	EndFunction

	float Function getPainMultiplier()
		return 0.8*MOD_Sincerity
	EndFunction

	float Function getRapeMultiplier()
		return 1.2*MOD_Liveliness
	EndFunction
	
	float Function getFeelingMultiplier() ; How much this mood affects emotions wrt training
		return 0.0 ; completely paralyzed, no expression of feelings
	EndFunction

	float Function getEmotionMultiplier() ; How much this mood affects emotions wrt training
		return 0.0 ; completely paralyzed, no expression of anything else but fear
	EndFunction
	
	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; Slave is terrified
		if RandomFloat() > MOD_Prudent
			actor_alias.Anim_Cower()
			SetNextPunishmentReasonSilent(3) ; "cowering"
		else
			actor_alias.Anim_Cries()
			SetNextPunishmentReasonSilent(4) ; "crying"
			SetNextPraiseReasonSilent(4) ; "crying"
		endif
		ChooseDrunkIdle()
	EndFunction
	
	Function ChooseTopic()
		bool not_respectful = IsNotRespectful(0.9)
		if not_respectful
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodTerror,PlayerRef)
		else
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodTerrorRespectful,PlayerRef)
		endif
	EndFunction

	bool Function IsScaredToObey()
		return true
	EndFunction

	bool Function IsAfraid()
		return true
	EndFunction

	bool Function MakeRunAway()
		;LogTrace("runaway chance=0 terrified!")
		return false
	EndFunction

	bool Function MakeRunAwayGang(float xfriendship)
		;LogTrace("runaway gang chance=0 terrified!")
		return false
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "a terrified "
    EndFunction

	int Function GetMoodIndex()
		return 4 ; "terrified"
	EndFunction

	Function SetRelationshipToPlayer()
		if akRef.getRelationshipRank(PlayerRef) > -(2)
			akRef.setRelationshipRank(PlayerRef, akRef.getRelationshipRank(PlayerRef) - 1)
		endif
	EndFunction
EndState

State scared
	Function StartMood()
		mood_swing_max *= 2
		LogTrace("mood=scared start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" "+actorBeVerb+" scared")
		akRef.SetFactionRank(DOM01.DOMMoodAfraid,3)
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(9,60) ; Mood fear expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodAfraid)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if !MakeRunAway()
			if !RecoverFrom()
				SetExpressionByMood()
				TryFearTears()
				ChooseMoodSpontaneousOnTick(0.1)
			endif
		endif
	EndFunction

	Function OnMoodUpdate()
		if !actor_alias.is_moving && RandomFloat() < 0.05
			ChooseIdle()
		endif
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.1)
			mood = "shock"
		elseif RandomFloat() < (__chance_broken * 0.05)
			mood = "broken"
		elseif MakeMoodSad(0.15)
			;SetMoodSad()
		elseif MakeMoodAngry(0.15)
			;SetMoodAngry
		elseif MakeMoodAshamed(0.5)
			;SetMoodAshamed()
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndPunishment(Float severity)
		; extra fear training
		TrainFear(severity * 0.1)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if RandomFloat() < (__chance_shock * 0.1)
			mood = "shock"
			return
		endif
		if had_orgasm && MakeMoodAshamed(1.0)
			;SetMoodAshamed()
		elseif __is_aroused_for > 0 && MakeMoodAshamed(0.5)
			;SetMoodAshamed()
		elseif MakeMoodAshamed(0.25)
			;SetMoodAshamed()
		elseif RandomFloat() < (__chance_broken * 0.05)
			mood = "broken"
		elseif !(__is_aroused_for > 0) && MakeMoodSad(0.15)
			;SetMoodSad()
		elseif RandomFloat() < 0.1 && RandomFloat() < MOD_Prudent
			MakeCry()
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		Float chance = __chance_recover_from_afraid*__chance_recently_punished_inverted
		;LogTrace("recover scared chance="+chance)
		if RandomFloat() < chance
			ChooseMoodChange()
			return true
		endif
		return false
	EndFunction
	
	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		if is_vaginal
			return 1.6*MOD_Anxiety
		endif
		return MOD_Anxiety
	EndFunction
	
	float Function getFeelingMultiplier() ; How much this mood affects emotions wrt training
		return 1.75*MOD_Sociability ; scared, fear passive mood, dominated by feelings
	EndFunction

	float Function getEmotionMultiplier() ; How much this mood affects emotions wrt training
		return 0.25*MOD_Panic ; scared, fear passive mood, dominated by feelings
	EndFunction

	Float Function RunAwayMoodBase()
		return 0.25
	EndFunction

	Float Function CallForHelpMoodBase()
		return 0.5
	EndFunction
	
	Float Function StopWaitingMoodBase()
		return 0.25-fear_training / 400.0
	EndFunction

	Float Function BreakRestraintMoodBase()
		return 0.3
	EndFunction

	Float Function StopOrderMoodBase(float training)
		return (0.25-( training / 400.0 ))+(0.25-( fear_training / 400.0 ))
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; Slave is scared
		if RandomFloat() < MOD_Fearfulness
			actor_alias.Anim_Nervous()
		elseif RandomFloat() < MOD_Humility
			actor_alias.Anim_PleaseStop()
			SetNextPunishmentReasonSilent(1) ; "begging to stop"
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction
	
	Function ChooseTopic()
		bool not_respectful = IsNotRespectful(1.1)
		if not_respectful
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodScared,PlayerRef)
		else
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodScaredRespectful,PlayerRef)
		endif
	EndFunction

	bool Function IsScaredToObey()
		return true
	EndFunction

	bool Function IsObedient()
		if timer_obedient > 0 || RandomFloat() < MOD_Anxiety || RandomFloat()*100.0 < fear_training
			return true
		endif
		return false
	EndFunction

	bool Function IsAfraid()
		return true
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "a scared "
    EndFunction

	int Function GetMoodIndex()
		return 5 ; "scared"
	EndFunction

	Function SetRelationshipToPlayer()
		akRef.setRelationshipRank(PlayerRef, -(1))
	EndFunction
EndState

State ashamed
	Function StartMood()
		mood_swing_max *= 2
		LogTrace("mood=ashamed start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" "+actorBeVerb+" ashamed")
		akRef.SetFactionRank(DOM01.DOMMoodAshamed,1)
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(14,100) ; Mood disgusted expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodAshamed)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if !MakeRunAway()
			if !RecoverFrom()
				SetExpressionByMood()
				TryShameTears()
				ChooseMoodSpontaneousOnTick(0.1)
			endif
		endif
	EndFunction

	Function OnMoodUpdate()
	EndFunction

	bool Function IsAshamed()
		return true
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.25)
			mood = "shock"
		elseif RandomFloat() < (__chance_broken * 0.05)
			mood = "broken"
		elseif MakeMoodAfraid(0.05)
			;SetMoodAfraid()
		elseif MakeMoodSad(0.1)
			;SetMoodSad()
		elseif MakeMoodAngry(0.1)
			;SetMoodAngry
		elseif RandomFloat() < 0.25 && RandomFloat() < MOD_Prudent
			MakeCry()
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndPunishment(Float severity)
		; extra humiliation training
		TrainHumiliation(severity * 0.1)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if RandomFloat() < (__chance_shock * 0.25)
			mood = "shock"
			return
		endif
		if RandomFloat() < (__chance_broken * 0.05)
			mood = "broken"
		elseif !(__is_aroused_for > 0) && MakeMoodSad(0.1)
			;SetMoodSad()
		elseif RandomFloat() < 0.5 && RandomFloat() < MOD_Prudent
			MakeCry()
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		Float chance = __chance_recover_from_ashamed * __chance_recently_punished_inverted
		;LogTrace("recover ashamed chance="+chance)
		if RandomFloat() < chance
			ChooseMoodChange()
			return true
		endif
		return false
	EndFunction
	
	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		return 2.0*MOD_Anxiety
	EndFunction

	float Function getRapeMultiplier()
		return 1.5*MOD_Liveliness
	EndFunction

	float Function getScoldMultiplier()
		return 1.5*MOD_Laborious
	EndFunction

	float Function getPraiseMultiplier()
		return 1.5*MOD_Organized
	EndFunction

	float Function getArousalBonus()
		return 0.1
	EndFunction
	
	Float Function RunAwayMoodBase()
		return 0.4
	EndFunction
	
	Float Function StopWaitingMoodBase()
		return 0.5-fear_training / 200.0
	EndFunction

	Float Function BreakRestraintMoodBase()
		return 0.2
	EndFunction

	Float Function StopOrderMoodBase(float training)
		return (0.8-( training / 125.0 ))
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; Slave is ashamed
		if RandomFloat()*100.0 > HEXACO_eXtraversion && RandomFloat()*100.0 > humiliation
			TryCoverSelf()
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction

	Function ChooseTopic()
		bool not_respectful = IsNotRespectful(1.1)
		if not_respectful
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodAshamed,PlayerRef)
		else
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodAshamedRespectful,PlayerRef)
		endif
	EndFunction

	bool Function IsObedient()
		if timer_obedient > 0 || RandomFloat() < MOD_Naivety || RandomFloat()*100.0 < humiliation
			return true
		endif
		return false
	EndFunction

	bool Function MakeStopMasturbate()
		;LogTrace("chance stop masturbate=0 mood is ashamed")
		return false
	EndFunction

	bool Function IsFeelingAshamed()
		return true
	EndFunction

	bool Function IsShamed()
		return true
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "a shamed "
    EndFunction

	int Function GetMoodIndex()
		return 6 ; "ashamed"
	EndFunction

	Function SetRelationshipToPlayer()
		akRef.setRelationshipRank(PlayerRef, -(1))
	EndFunction
EndState

State sad
	Function StartMood()
		mood_swing_max *= 2
		LogTrace("mood=sad start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" "+actorBeVerb+" getting sad")
		akRef.SetFactionRank(DOM01.DOMMoodSad,1)
		akRef.AddToFaction(DOM01.DOMTobeComfortedFaction)
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(11,100) ; Mood sad expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodSad)
		if !actor_alias.hasTears()
			akRef.RemoveFromFaction(DOM01.DOMTobeComfortedFaction)
		endif
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if !MakeRunAway()
			if ! RecoverFrom()
				SetExpressionByMood()
				TrySadnessTears()
				ChooseMoodSpontaneousOnTick(0.1)
			endif
		endif
	EndFunction

	Function OnMoodUpdate()
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.5)
			mood = "shock"
		elseif RandomFloat() < (__chance_broken * 0.1)
			mood = "broken"
		elseif MakeMoodAngry(0.1)
			;SetMoodAngry
		elseif MakeMoodAfraid(0.15)
			;SetMoodAfraid()
		elseif MakeMoodAshamed(0.2)
			;SetMoodAshamed()
		elseif RandomFloat() < 0.5 && RandomFloat() < MOD_Prudent
			MakeCry()
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndPunishment(Float severity)
		; extra resignation training
		TrainHumiliation(severity * 0.1)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if RandomFloat() < (__chance_shock * 0.5)
			mood = "shock"
			return
		endif
		if had_orgasm && MakeMoodAshamed(1.0)
			;SetMoodAshamed()
		elseif __is_aroused_for > 0 && MakeMoodAshamed(0.5)
			;SetMoodAshamed()
		elseif MakeMoodAshamed(0.25)
			;SetMoodAshamed()
		elseif RandomFloat() < (__chance_broken * 0.1)
			mood = "broken"
		elseif RandomFloat() < 0.5 && RandomFloat() < MOD_Prudent
			MakeCry()
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		Float chance = __chance_recover_from_sad*__chance_recently_punished_inverted
		;LogTrace("recover sad chance="+chance)
		if RandomFloat() < chance
			ChooseMoodChange()
			return true
		endif
		return false
	EndFunction

	float Function getPainMultiplier()
		return 1.5*MOD_Sincerity
	EndFunction

	float Function getScoldMultiplier()
		return 0.5*MOD_Laborious
	EndFunction

	float Function getPraiseMultiplier()
		return 1.5*MOD_Organized
	EndFunction
	
	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		if is_oral
			return 1.6*MOD_Anxiety
		endif
		return MOD_Anxiety
	EndFunction
	
	Float Function RunAwayMoodBase()
		return 0.40
	EndFunction

	Float Function CallForHelpMoodBase()
		return 0.25
	EndFunction
	
	Float Function StopWaitingMoodBase()
		return 0.5-fear_training / 200.0
	EndFunction

	Float Function BreakRestraintMoodBase()
		return 0.2
	EndFunction

	Float Function StopOrderMoodBase(float training)
		return (0.6-( training / 167.0 ))
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; Slave is sad
		if RandomFloat() < MOD_Prudent
			actor_alias.Anim_Cries()
			SetNextPunishmentReasonSilent(4) ; "crying"
			SetNextPraiseReasonSilent(4) ; "crying"
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction

	Function ChooseTopic()
		bool not_respectful = IsNotRespectful(1.1)
		if not_respectful
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodSad,PlayerRef)
		else
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodSadRespectful,PlayerRef)
		endif
	EndFunction

	bool Function IsObedient()
		if timer_obedient > 0 || RandomFloat() < MOD_Prudent || RandomFloat()*100.0 < resignation
			return true
		endif
		return false
	EndFunction

	bool Function IsSad()
		return true
	EndFunction
	
 	bool Function IsCrying()
		return true
	EndFunction

   string Function GetMoodNameThirdPerson()
		return "a sobbing "
    EndFunction

	int Function GetMoodIndex()
		return 7 ; "sad"
	EndFunction

	Function SetRelationshipToPlayer()
		akRef.setRelationshipRank(PlayerRef, -(1))
	EndFunction
EndState

Function ClearMemories()
	ResetTextMemories()
	memory_capture_time = 0.0
	memory_entries = 0
	memory_capture_mood = -1
	memory_capture_ntimes = 0
	memory_capture_rtimes = 0
	memory_capture_ftimes = 0
EndFunction

; Full text of before capture memory
string Property memory_origin_txt         Auto Hidden 
; Time of capture memory
float  Property memory_capture_time = 0.0 Auto Hidden
int    Property memory_capture_mood       Auto Hidden
int    Property memory_capture_ntimes     Auto Hidden ; number of times enslaved
int    Property memory_capture_rtimes     Auto Hidden ; number of times recruited
int    Property memory_capture_ftimes     Auto Hidden ; number of times freed
string Property memory_capture_location   Auto Hidden
string Property memory_capture_occupation Auto Hidden
string Property memory_capture_origin     Auto Hidden
string Property memory_capture_type       Auto Hidden
string Property memory_capture_txt        Auto Hidden ; Full text of capture memory

; Abuses memory
int    Property memory_entries        Auto Hidden
float[] __memory_abuse_time
float[] Property memory_abuse_time Hidden
	float[] Function Get()	
		if !__memory_abuse_time
			__memory_abuse_time = new float[128] ; 
			memory_entries = 0
		endif
		return __memory_abuse_time
	EndFunction
EndProperty

int[] __memory_abuse_category
int[] Property memory_abuse_category Hidden
	int[] Function Get()	
		if !__memory_abuse_category
			__memory_abuse_category = new int[128] ; 
		endif
		return __memory_abuse_category
	EndFunction
EndProperty

int[] __memory_abuse_mood
int[] Property memory_abuse_mood Hidden
	int[] Function Get()	
		if !__memory_abuse_mood
			__memory_abuse_mood = new int[128] ; 
		endif
		return __memory_abuse_mood
	EndFunction
EndProperty

int[] __memory_abuse_level
int[] Property memory_abuse_level Hidden
	int[] Function Get()	
		if !__memory_abuse_level
			__memory_abuse_level = new int[128] ; 
		endif
		return __memory_abuse_level
	EndFunction
EndProperty

int[] __memory_abuse_ntimes
int[] Property memory_abuse_ntimes Hidden
	int[] Function Get()	
		if !__memory_abuse_ntimes
			__memory_abuse_ntimes = new int[128] ; 
		endif
		return __memory_abuse_ntimes
	EndFunction
EndProperty

bool[] __memory_abuse_respectful
bool[] Property memory_abuse_respectful Hidden
	bool[] Function Get()	
		if !__memory_abuse_respectful
			__memory_abuse_respectful = new bool[128] ; 
		endif
		return __memory_abuse_respectful
	EndFunction
EndProperty

bool[] __memory_abuse_flag
bool[] Property memory_abuse_flag Hidden
	bool[] Function Get()	
		if !__memory_abuse_flag
			__memory_abuse_flag = new bool[128] ; 
		endif
		return __memory_abuse_flag
	EndFunction
EndProperty

string[] __memory_abuse_location
string[] Property memory_abuse_location Hidden
	string[] Function Get()	
		if !__memory_abuse_location
			__memory_abuse_location = new string[128] ; 
		endif
		return __memory_abuse_location
	EndFunction
EndProperty

string[] __memory_abuse_type
string[] Property memory_abuse_type Hidden
	string[] Function Get()	
		if !__memory_abuse_type
			__memory_abuse_type = new string[128] ; 
		endif
		return __memory_abuse_type
	EndFunction
EndProperty

string[] __memory_abuse_reason
string[] Property memory_abuse_reason Hidden
	string[] Function Get()	
		if !__memory_abuse_reason
			__memory_abuse_reason = new string[128] ; 
		endif
		return __memory_abuse_reason
	EndFunction
EndProperty

string[] __memory_abuse_txt
string[] Property memory_abuse_txt Hidden
	string[] Function Get()	
		if !__memory_abuse_txt
			__memory_abuse_txt = new string[128] ;
		endif
		return __memory_abuse_txt
	EndFunction
EndProperty

int[] __memory_abuse_ncat     ; 0: salute, 1: punishment, 2: praise, 3: insult, 4: flatter, 5: comfort, 6: promise, 7: promise kept, 8: threat, 9: scold
                              ; 10: showering, 11: rape, 12: sex, 13: check, 14: kiss, 15: masturbate, 16: pose, 17: combat, 18: Tied, 19: pricing
							  ; 20: friendship, 21: lost friendship, 22: recover old friend, 23: drunk, 24: be silent, 25: be respectful, 26: control orgasm, 27: orgasm, 28: ashamed, 29: shock, 
							  ; 30: broken, 31: fall in love, 32: chatting, 33: walk on four, 36: drugged, 37: addicted, 38: enslaved, 39: recruited, 40: status update
							  ; 41: discover kink, 42: teasing kink, 43: acquired kink, 44: jail, 45: sweep, 46: work, 49: strip
							  ; 50: wear collar, 51: gag, 52: blindfold, 53: branding, 54: plug anal, 55: plug vaginal
							  ; 60: virginity
int[] Property memory_abuse_ncat Hidden
	int[] Function Get()	
		if !__memory_abuse_ncat
			__memory_abuse_ncat = new int[128] ; 
		endif
		return __memory_abuse_ncat
	EndFunction
EndProperty

bool Function HasMemory(int cat)
	if memory_abuse_ncat[cat] > 0
		return true
	else
		return false
	endif
EndFunction

bool Function FreeSomeMemory()
	;LogTrace("FreeSomeMemory nentries="+memory_entries)
	if memory_entries < memory_abuse_time.length 
		return true
	endif
	if memory_abuse_time.length <= 3
		return false
	endif
	if MergeMemories() ; try to merge repeating memories
		return true
	endif
	if FreeSomeNotSoImportantMemory(1) ; try to free some of the punishments
		return true
	endif
	if FreeSomeNotSoImportantMemory(12) ; try to free some of the basic abuse
		return true
	endif
	if FreeSomeMoreImportantMemory(12) ; try to free more even if not same category
		return true
	endif
	if FreeSomeNotSoImportantMemory(25) ; try to free some more up to friendship information
		return true
	endif
	if FreeSomeMoreImportantMemory(25) ; try to free more
		return true
	endif
	if FreeSomeNotSoImportantMemory(60) ; try to free a few more memories
		return true
	endif
	if FreeSomeMoreImportantMemory(60) ; try to free more
		return true
	endif
	if FreeSomeNotSoImportantMemory(100) ; try to free anything
		return true
	endif
	if FreeSomeMoreImportantMemory(100) ; try to free more
		return true
	endif
	return false
EndFunction

bool Function MergeMemories()
	int n = memory_entries - (1)
	;LogTrace("MergeMemories nentries-1="+n)
	if n <= 0
		return true
	endif
	int idx = 1
	bool is_lost       = false
	bool some_lost     = false
	int prev_idx       = 0
	int prev_cat       = __memory_abuse_category[0]
	string prev_type   = __memory_abuse_type[0]
	string prev_reason = __memory_abuse_reason[0]
	bool prev_flag     = memory_abuse_flag[0]
	while idx < n
		int cat       = __memory_abuse_category[idx]
		string type   = __memory_abuse_type[idx]
		string reason = __memory_abuse_reason[idx]
		bool flag     = __memory_abuse_flag[idx]
		;LogTrace("Check memory: "+idx+" cat="+cat+" type="+type+" reason="+reason+" ntimes="+memory_abuse_ntimes[idx]+" txt="+__memory_abuse_txt[idx])
		if prev_cat == cat && prev_reason == reason && (prev_flag == flag)
			if (prev_type == type) || cat == 13 || cat == 14 ; same type or kiss/check with same outcome
				;LogTrace("Check memory: "+idx+" current memory is lost")
				is_lost   = true
				some_lost = true
			endif
		elseif prev_cat == cat && prev_type == type
			if cat <= 2 ; merge praising and punishment
				is_lost   = true
				some_lost = true
				if __memory_abuse_reason[prev_idx] == "" || __memory_abuse_reason[prev_idx] == "no reason"
					__memory_abuse_reason[prev_idx] = reason
				elseif reason != "" && reason != "no reason"
					__memory_abuse_reason[prev_idx] = __memory_abuse_reason[prev_idx] +", " + reason
				endif
			endif
		endif
		if is_lost 
			int ntimes = memory_abuse_ntimes[prev_idx]
			if ntimes == 0
				ntimes = 1
			endif
			;LogTrace("Lost memory: cat="+cat+" txt="+__memory_abuse_txt[idx]+" ntimes="+ntimes)
			__memory_abuse_ntimes[prev_idx] = ntimes + 1
			CollapseMemory(idx)
			cat    =  __memory_abuse_category[idx]
			type   =  __memory_abuse_type[idx]
			reason =  __memory_abuse_reason[idx]
			flag   =  __memory_abuse_flag[idx]
			n = memory_entries - (1)
		else
			prev_cat    = cat
			prev_type   = type
			prev_reason = reason
			prev_flag   = flag
			prev_idx    = idx
			idx += 1
		endif
		is_lost = false
	endwhile
	return some_lost
EndFunction

bool Function FreeSomeNotSoImportantMemory(int cat_level)
	int n = memory_entries - (1)
	;LogTrace("FreeSomeNotSoImportantMemory cat="+cat_level+" nentries-1="+n)
	if n <= 0
		return true
	endif
	int idx = 1
	bool is_lost   = false
	bool some_lost = false
	bool prev_lost = false
	int prev_cat = __memory_abuse_category[0]
	while idx < n
		int cat =  __memory_abuse_category[idx]
		;LogTrace("Check memory: "+idx+" cat="+cat+" txt="+__memory_abuse_txt[idx])
		if prev_lost
			;LogTrace("Check memory: "+idx+" previous memory was lost")
			prev_lost = false
		elseif cat <= cat_level && prev_cat == cat
			;LogTrace("Check memory: "+idx+" current memory is lost")
			is_lost   = true
			some_lost = true
			prev_lost = true
		endif
		if is_lost 
			;LogTrace("Lost memory: cat="+cat+" txt="+__memory_abuse_txt[idx])
			CollapseMemory(idx)
			cat =  __memory_abuse_category[idx]
			n = memory_entries - (1)
		endif
		is_lost = false
		prev_cat = cat
		idx += 1
	endwhile
	return some_lost
EndFunction

bool Function FreeSomeMoreImportantMemory(int cat_level)
	;LogTrace("FreeSomeMoreImportantMemory cat="+cat_level)
	int n = memory_entries - (1)
	if n <= 0
		return true
	endif
	int idx = 1
	int idx2 = 1
	bool is_lost   = false
	bool some_lost = false
	bool prev_lost = false
	int prev_cat = __memory_abuse_category[0]
	while idx < n
		int cat =  __memory_abuse_category[idx]
		if prev_lost
			prev_lost = false
		elseif cat < cat_level
			is_lost   = true
			some_lost = true
			prev_lost = true
		endif
		if is_lost 
			;LogTrace("Lost memory: cat="+__memory_abuse_category[idx]+" txt="+__memory_abuse_txt[idx])
			CollapseMemory(idx)
			cat =  __memory_abuse_category[idx]
			n = memory_entries - (1)
		endif
		is_lost = false
		prev_cat = cat
		idx2 = idx
		idx += 1
	endwhile
	return some_lost
EndFunction

Function ResetTextMemories()
	int n = memory_entries
	int idx = 0
	while idx < n
		memory_abuse_txt[idx]        = ""
		idx += 1
	endwhile
	memory_capture_txt = ""
	memory_origin_txt = ""
EndFunction

Function ResetAllMemories()
	int n = memory_entries
	int idx = 0
	while idx < n
		memory_abuse_txt[idx]        = ""
		idx += 1
	endwhile
	memory_entries = 0
EndFunction

Function CollapseMemory(int istart)
	;LogTrace("CollapseMemory idx="+istart)
	int n = memory_entries - (1)
	if n <= 0
		return
	endif
	int idx = istart
	int cat =  __memory_abuse_category[idx] ; decrease category counter
	__memory_abuse_ncat[cat] = __memory_abuse_ncat[cat] - (1)
	while idx < n
		__memory_abuse_category[idx]   = __memory_abuse_category[idx+1]
		__memory_abuse_time[idx]       = __memory_abuse_time[idx+1]
		__memory_abuse_mood[idx]       = __memory_abuse_mood[idx+1]
		__memory_abuse_level[idx]      = __memory_abuse_level[idx+1]
		__memory_abuse_respectful[idx] = __memory_abuse_respectful[idx+1]
		__memory_abuse_flag[idx]       = __memory_abuse_flag[idx+1]
		__memory_abuse_location[idx]   = __memory_abuse_location[idx+1]
		__memory_abuse_type[idx]       = __memory_abuse_type[idx+1]
		__memory_abuse_reason[idx]     = __memory_abuse_reason[idx+1]
		__memory_abuse_txt[idx]        = "" ; reset text of next memory
		idx += 1
	endwhile
	memory_entries -= 1
EndFunction

int Function StoreNewMemory(int cat, float time, string loc, string type, string reason, int the_mood, int the_level, bool is_respectful, bool flag_value)
	if memory_entries >= memory_abuse_time.length 
		if !FreeSomeMemory()
			return -1 ; Memory is full, forget it.
		endif
	endif
	;LogTrace("StoreNewMemory "+GetName()+" cat="+cat+" type="+type)
	int idx = memory_entries
	if idx > 1
		int prev_idx = idx-(1)
		if memory_abuse_category[prev_idx] == cat
			if memory_abuse_type[prev_idx] == type || cat == 13 || cat == 14 ; same type or kiss/check with same outcome
				if memory_abuse_reason[prev_idx] == reason
					memory_abuse_ntimes[prev_idx] = memory_abuse_ntimes[prev_idx] + 1
					memory_abuse_txt[prev_idx]    = "" ; reset text
					return prev_idx
				endif
			endif
		endif
	endif
	memory_entries += 1
	memory_abuse_time[idx]       = time
	memory_abuse_category[idx]   = cat
	memory_abuse_mood[idx]       = the_mood
	memory_abuse_level[idx]      = the_level
	memory_abuse_ntimes[idx]     = 1
	memory_abuse_respectful[idx] = is_respectful
	memory_abuse_flag[idx]       = flag_value
	memory_abuse_location[idx]   = loc
	memory_abuse_type[idx]       = type
	memory_abuse_reason[idx]     = reason
	memory_abuse_ncat[cat]       = memory_abuse_ncat[cat] + 1
	memory_abuse_txt[idx]        = "" ; reset text
	return idx
EndFunction

; check last entry category. Also check type unless type=""
bool Function LastMemoryIsCat(int cat, string type = "")
	if memory_entries <= 0
		return false
	endif
	int idx = memory_entries - (1)
	if memory_abuse_category[idx] != cat
		return false
	endif
	if type == ""
		return true
	endif
	if memory_abuse_type[idx] == type
		return true
	endif
	return false
EndFunction

Function RegisterNewMemory(int idx)
	if !DOM01.sendDOMExternalEventToggleExt3 && !actor_alias.sendExternalEventToggleExt3
		return ; no event to send
	endif
	actor_alias.SendExternalEventSSSBS("DiaryUpdate",__memory_abuse_type[idx],__memory_abuse_reason[idx],__memory_abuse_flag[idx],__memory_abuse_txt[idx])
EndFunction

State shock
	Function StartMood()
		SendNotificationAction(name+" "+actorBeVerb+" in shock")
		LogTrace("mood=shock start "+mood_swing_ticks+"/"+mood_swing_max)
		number_of_shock += 1
		akRef.SetFactionRank(DOM01.DOMMoodShock,1)
		akRef.AddToFaction(DOM01.DOMTobeComfortedFaction)
		TrainAfterShock()
		actor_alias.TurnOffCrimeFaction()
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(12,100) ; Mood surprise expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodShock)
		if !actor_alias.hasTears()
			akRef.RemoveFromFaction(DOM01.DOMTobeComfortedFaction)
		endif
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if ! RecoverFrom()
			SetExpressionByMood()
			TryDistressTears()
			ChooseMoodSpontaneousOnTick(0.1)
		endif
	EndFunction

	Function OnMoodUpdate()
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < 0.1 && RandomFloat()-(0.1) < MOD_Prudent
			MakeCry()
		elseif RandomFloat() < (__chance_broken * 0.1)
			mood = "broken"
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndPunishment(Float severity)
		; extra training
		TrainSubmission(severity * 0.1)
		TrainFear(severity * 0.1)
		TrainHumiliation(severity * 0.1)
		TrainAnger(severity * 0.2)
		TrainResignation(severity * 0.1)
		TrainRespect(severity * 0.1)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if had_orgasm && MakeMoodAshamed(1.0)
			;SetMoodAshamed()
		elseif __is_aroused_for > 0 && MakeMoodAshamed(0.5)
			;SetMoodAshamed()
		elseif MakeMoodAshamed(0.25)
			;SetMoodAshamed()
		elseif RandomFloat() < 0.1 && RandomFloat()-(0.1) < MOD_Prudent
			MakeCry()
		elseif RandomFloat() < (__chance_broken * 0.1)
			mood = "broken"
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		float chance = __chance_recover_from_shock * __chance_recently_punished_inverted
		;LogTrace("recover shock chance="+chance)
		if RandomFloat() < chance
			ChooseMoodChange()
			return true
		endif
		return false
	EndFunction
	
	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		return 1.5*MOD_Anxiety
	EndFunction

	float Function getPainMultiplier()
		return 0.5*MOD_Sincerity
	EndFunction

	float Function getRapeMultiplier()
		return 1.5*MOD_Liveliness
	EndFunction
	
	float Function getScoldMultiplier()
		return 0.5*MOD_Laborious
	EndFunction

	float Function getPraiseMultiplier()
		return 0.5*MOD_Organized
	EndFunction

	Float Function StopOrderMoodBase(float training)
		return 1.0
	EndFunction

	float Function getFeelingMultiplier() ; How much this mood affects emotions wrt training
		return 0.0 ; in shock no time for feelings
	EndFunction

	float Function getEmotionMultiplier() ; How much this mood affects emotions wrt training
		return 0.25*MOD_Panic ; in shock, only emotions can go through
	EndFunction
	
	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; Slave is in shock
		if RandomFloat() < MOD_Panic
			actor_alias.Anim_Shocked()
		elseif RandomFloat() > MOD_Prudent
			actor_alias.Anim_Cower()
			SetNextPunishmentReasonSilent(3) ; "cowering"
		else
			actor_alias.Anim_Cries()
			SetNextPunishmentReasonSilent(4) ; "crying"
			SetNextPraiseReasonSilent(4) ; "crying"
		endif
		ChooseDrunkIdle()
	EndFunction
	
	Function ChooseTopic()
		bool not_respectful = IsNotRespectful(1.1)
		if not_respectful
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodShocked,PlayerRef)
		else
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodShockedRespectful,PlayerRef)
		endif
	EndFunction

	Event OnToldOff(int ireason)
		ChooseIdle()
	EndEvent

	bool Function IsBrokenToObey()
		return true
	EndFunction

	bool Function MakeAngryForUnfairness()
		return false
	EndFunction

	bool Function MakeAngryForInjustice()
		return false
	EndFunction

	bool Function MakeAfraid()
		return false
	EndFunction

	bool Function MakeSadForUnfairness()
		return false
	EndFunction

	bool Function MakeSadForInjustice()
		return false
	EndFunction

	bool Function MakeAshamed()
		;LogTrace("ashamed chance=0 shocked!")
		return false
	EndFunction

	bool Function MakeRunAway()
		;LogTrace("runaway chance=0 shocked!")
		return false
	EndFunction

	bool Function MakeRunAwayGang(float xfriendship)
		;LogTrace("runaway gang chance=0 shocked!")
		return false
	EndFunction

	bool Function IsShocked()
		return true
	EndFunction

    string Function GetMoodName()
		return "in shock"
    EndFunction

    string Function GetMoodNameThirdPerson()
		return "a shocked "
	EndFunction

	int Function GetMoodIndex()
		return 8 ; "shock"
	EndFunction

	Function SetRelationshipToPlayer()
		akRef.setRelationshipRank(PlayerRef, 0)
	EndFunction
EndState

float broken_time = 0.0
State broken
	Function StartMood()
		; -=TAK=- Notification added for debugging or atmosphere
		SendNotificationAction(name+" "+actorBeVerb+" broken")
		LogTrace("mood=broken start "+mood_swing_ticks+"/"+mood_swing_max)
		number_of_broken += 1
		akRef.SetFactionRank(DOM01.DOMMoodBroken,1)
		TrainBroken()
		actor_alias.TurnOffCrimeFaction()
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
		broken_time = GetCurrentGameTime()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(13,100) ; Mood puzzled expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodBroken)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		float current_time = GetCurrentGameTime()
		float elapsed_time = current_time-broken_time
		broken_time = current_time
		timer_for_broken += elapsed_time
		mood_swing_ticks += 1
		if !RecoverFrom()
			SetExpressionByMood()
			TryFearTears()
			ChooseMoodSpontaneousOnTick(0.1)
		endif
	EndFunction

	Function OnMoodUpdate()
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.25)
			mood = "shock"
		else
			ChooseIdle()
		endif
	EndEvent
	
	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if RandomFloat() < (__chance_shock * 0.25)
			mood = "shock"
			return
		endif
		if had_orgasm && MakeMoodAshamed(0.25)
			;SetMoodAshamed()
		elseif __is_aroused_for > 0 && MakeMoodAshamed(0.1)
			;SetMoodAshamed()
		elseif MakeMoodAshamed(0.05)
			;SetMoodAshamed()
		elseif !(__is_aroused_for > 0) && MakeMoodSad(0.05)
			;SetMoodSad()
		elseif RandomFloat() < 0.2 && RandomFloat() < MOD_Prudent
			MakeCry()
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		Float chance = __chance_recover_from_broken
		float rand = RandomFloat()
		;LogTrace("recover broken chance="+chance)
		if rand < chance
			ChooseMoodChange()
			return true
		endif
		return false
	EndFunction

	float Function getFeelingMultiplier() ; How much this mood affects emotions wrt training
		return 2.0*MOD_Sociability ; broken, starts to think before talking
	EndFunction

	float Function getEmotionMultiplier() ; How much this mood affects emotions wrt training
		return 0.1*MOD_Panic ; broken so emotions are supressed by training
	EndFunction

	Float Function RunAwayMoodBase()
		return 0.05
	EndFunction

	Float Function CallForHelpMoodBase()
		return 0.05
	EndFunction
	
	Float Function StopWaitingMoodBase()
		return 0.1-fear_training / 1000.0
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; slave is broken
		if is_slave && RandomFloat()*42.0 < __total_training
			actor_alias.Anim_Salute()	
			AddNextPraiseReason(1) ; "being a good slave"
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction

	Function ChooseTopic()
		bool not_respectful = IsNotRespectful(1.0)
		if not_respectful
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodBroken,PlayerRef)
		else
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodBrokenRespectful,PlayerRef)
		endif
	EndFunction

	Event OnToldOff(int ireason)
		ChooseMoodSpontaneous(0.1)
		ChooseIdle()
	EndEvent

	bool Function IsBrokenToObey()
		return true
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "a broken "
    EndFunction

	int Function GetMoodIndex()
		return 9 ; "broken"
	EndFunction

	Function SetRelationshipToPlayer()
		akRef.setRelationshipRank(PlayerRef, 1)
	EndFunction
EndState

State neutral
	Function StartMood()
		if is_slave
			mood_swing_max /= 5
		endif
		LogTrace("mood=neutral start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" cools down")
		akRef.SetFactionRank(DOM01.DOMMoodNeutral,1)
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(7,100) ; Mood neutral expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodNeutral)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if !MakeRunAway()
			SetExpressionByMood()
			actor_alias.TryRemoveTears(1)
			ChooseMoodSpontaneousOnTick(0.1)
		endif
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.25)
			mood = "shock"
		elseif MakeMoodAfraid(0.5)
			;SetMoodAfraid()
		elseif MakeMoodAngry(0.25)
			;SetMoodAngry()
		elseif MakeMoodSad(0.25)
			;SetMoodSad()
		elseif MakeMoodAshamed(0.25)
			;SetMoodAshamed()
		else
			ChooseIdle()
		endif
	EndEvent
	
	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if RandomFloat() < (__chance_shock * 0.25)
			mood = "shock"
			return
		endif
		if had_orgasm && MakeMoodAshamed(1.0)
			;SetMoodAshamed()
		elseif __is_aroused_for > 0 && MakeMoodAshamed(0.5)
			;SetMoodAshamed()
		elseif MakeMoodAshamed(0.25)
			;SetMoodAshamed()
		elseif !(__is_aroused_for > 0) && MakeMoodSad(0.25)
			;SetMoodSad()
		elseif (!had_orgasm) && MakeMoodAngry(0.25)
			;SetMoodAngry()
		else	
			ChooseIdle()
		endif
	EndEvent

	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		return 0.5*MOD_Anxiety
	EndFunction

	float Function getRapeMultiplier()
		return 0.5*MOD_Liveliness
	EndFunction
	
	Float Function RunAwayMoodBase()
		return 0.5
	EndFunction

	Float Function CallForHelpMoodBase()
		return 1.0
	EndFunction

	Float Function StopWaitingMoodBase()
		return 0.5-fear_training / 200.0
	EndFunction

	Float Function BreakRestraintMoodBase()
		return 0.6
	EndFunction

	Float Function StopOrderMoodBase(float training)
		return (1.0-( training / 100.0 ))
	EndFunction

	bool Function IsObedient()
		if timer_obedient > 0 || RandomFloat() < MOD_Laborious || RandomFloat()*100.0 < respect_training
			return true
		endif
		return false
	EndFunction

 	int Function GetMoodIndex()
		return 10 ; "neutral"
	EndFunction

   string Function GetMoodName()
		return "ok"
	EndFunction
EndState

State fine
	Function StartMood()
		LogTrace("mood=fine start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" "+actorBeVerb+" fine")
		akRef.SetFactionRank(DOM01.DOMMoodHappy,1)
		SetRelationshipToPlayer()
		SetExpressionByMood()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(10,60) ; Mood happy expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodHappy)
		ClearExpression()
	EndFunction
	
	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		SetExpressionByMood()
		actor_alias.TryRemoveTears(1)
		ChooseMoodSpontaneousOnTick(0.1)
	EndFunction

	Function ChooseIdle()
	EndFunction	

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.2)
			mood = "shock"
		elseif MakeMoodAfraid(0.35)
			;SetMoodAfraid()
		elseif MakeMoodAngry(0.2)
			;SetMoodAngry()
		elseif MakeMoodSad(0.2)
			;SetMoodSad()
		elseif MakeMoodAshamed(0.2)
			;SetMoodAshamed()
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if RandomFloat() < (__chance_shock * 0.1)
			mood = "shock"
			return
		endif
		if had_orgasm && MakeMoodAshamed(0.1)
			;SetMoodAshamed()
		elseif __is_aroused_for > 0 && MakeMoodAshamed(0.1)
			;SetMoodAshamed()
		elseif MakeMoodAshamed(0.1)
			;SetMoodAshamed()
		elseif !(__is_aroused_for > 0) && MakeMoodSad(0.1)
			;SetMoodSad()
		elseif (!had_orgasm) && MakeMoodAngry(0.1)
			;SetMoodAngry()
		else	
			ChooseIdle()
		endif
	EndEvent

 	bool Function IsHappy()
		return true
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "a content "
	EndFunction

	int Function GetMoodIndex()
		return 11 ; "fine"
	EndFunction

	Function SetRelationshipToPlayer()
		if akRef.GetRelationshipRank(PlayerRef) < 2
			akRef.SetRelationshipRank(PlayerRef, 2)
		endif
	EndFunction
EndState

State happy
	Function StartMood()
		LogTrace("mood=happy start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" "+actorBeVerb+" happy")
		akRef.SetFactionRank(DOM01.DOMMoodHappy,2)
		SetRelationshipToPlayer()
		SetExpressionByMood()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(10,80) ; Mood happy expression
	EndFunction
	
	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodHappy)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		SetExpressionByMood()
		actor_alias.TryRemoveTears(1)
		ChooseMoodSpontaneousOnTick(0.1)
	EndFunction

	Function ChooseIdle()
	EndFunction	

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.15)
			mood = "shock"
		elseif MakeMoodAfraid(0.25)
			;SetMoodAfraid()
		elseif MakeMoodAngry(0.15)
			;SetMoodAngry()
		elseif MakeMoodSad(0.15)
			;SetMoodSad()
		elseif MakeMoodAshamed(0.15)
			;SetMoodAshamed()
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if RandomFloat() < (__chance_shock * 0.05)
			mood = "shock"
			return
		endif
		if had_orgasm && MakeMoodAshamed(0.05)
			;SetMoodAshamed()
		elseif __is_aroused_for > 0 && MakeMoodAshamed(0.05)
			;SetMoodAshamed()
		elseif MakeMoodAshamed(0.05)
			;SetMoodAshamed()
		elseif !(__is_aroused_for > 0) && MakeMoodSad(0.05)
			;SetMoodSad()
		elseif (!had_orgasm) && MakeMoodAngry(0.05)
			;SetMoodAngry()
		else	
			ChooseIdle()
		endif
	EndEvent

 	bool Function IsHappy()
		return true
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "a happy "
    EndFunction

	int Function GetMoodIndex()
		return 12 ; "happy"
	EndFunction

	Function SetRelationshipToPlayer()
		if akRef.GetRelationshipRank(PlayerRef) < 3
			akRef.SetRelationshipRank(PlayerRef, 3)
		endif
	EndFunction
EndState

State loyal
	Function StartMood()
		; -=TAK=- Notification added for debugging or atmosphere
		SendNotificationActionMaster(name+" "+actorBeVerb+" now loyal to ","")
		LogTrace("mood=loyal start "+mood_swing_ticks+"/"+mood_swing_max)
		number_of_brainwashed += 1
		akRef.SetFactionRank(DOM01.DOMMoodLoyal,1)
		TrainResignation(30.0)
		TrainRespect(30.0)
		TrainFear(30.0)
		TrainAnger(30.0)
		actor_alias.TurnOffCrimeFaction()
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(10,50) ; Mood happy expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodLoyal)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		SetExpressionByMood()
		actor_alias.TryRemoveTears(1)
		ChooseMoodSpontaneousOnTick(0.1)
	EndFunction

	Function OnMoodUpdate()
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.2)
			mood = "shock"
		else
			ChooseIdle()
		endif
	EndEvent
	
	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if (!had_orgasm) && !(__is_aroused_for > 0) && RandomFloat() < (__chance_shock * 0.2)
			mood = "shock"
			return
		endif
		if had_orgasm && RandomFloat() < __chance_inlove*0.5
			mood = "inlove"
			return
		endif
		if had_orgasm && MakeMoodAshamed(0.2)
			;SetMoodAshamed()
		elseif __is_aroused_for > 0 && MakeMoodAshamed(0.1)
			;SetMoodAshamed()
		elseif MakeMoodAshamed(0.05)
			;SetMoodAshamed()
		elseif !(__is_aroused_for > 0) && MakeMoodSad(0.05)
			;SetMoodSad()
		elseif RandomFloat() < 0.1 && RandomFloat() < MOD_Prudent
			MakeCry()
		else	
			ChooseIdle()
		endif
	EndEvent

	float Function getPainMultiplier()
		return 2.0*MOD_Sincerity
	EndFunction

	float Function getPraiseMultiplier()
		return 2.0*MOD_Organized
	EndFunction

	float Function getScoldMultiplier()
		return 2.0*MOD_Laborious
	EndFunction

	float Function getFeelingMultiplier() ; How much this mood affects emotions wrt training
		return 2.0*MOD_Sociability ; loyal, feelings, dominated by training
	EndFunction

	float Function getEmotionMultiplier() ; How much this mood affects emotions wrt training
		return 0.0 ; loyal, so emotions are negated
	EndFunction

	Float Function RunAwayMoodBase()
		return 0.01
	EndFunction
	
	Float Function StopWaitingMoodBase()
		return 0.1-fear_training / 1000.0
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; slave is loyal
		if is_slave && RandomFloat()*83.3 < __total_training
			actor_alias.Anim_Salute()	
			AddNextPraiseReason(1) ; "being a good slave"
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction

	Function ChooseTopic()
		bool not_respectful = IsNotRespectful(0.7)
		if not_respectful
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodLoyal,PlayerRef)
		else
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodLoyalRespectful,PlayerRef)
		endif
	EndFunction

	Event OnToldOff(int ireason)
		ChooseMoodSpontaneous(0.1)
		ChooseIdle()
	EndEvent

	bool Function IsDevoted()
		return true
	EndFunction

	bool Function MakeRunAway()
		return false
	EndFunction

	bool Function MakeRunAwayGang(float xfriendship)
		return false
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "a loyal "
    EndFunction

	int Function GetMoodIndex()
		return 13 ; "loyal"
	EndFunction

	Function SetRelationshipToPlayer()
		if akRef.GetRelationshipRank(PlayerRef) < 3
			akRef.setRelationshipRank(PlayerRef, 3)
		endif
	EndFunction
EndState

int Function TrainRandom(float amount)
	float x = RandomFloat()*MOD_SumAll
	if x < MOD_Humility
		TrainSubmission(amount)
		return 0
	elseif x < MOD_Humility+MOD_Fearfulness
		TrainFear(amount)
		return 1
	elseif x < MOD_Humility+MOD_Fearfulness+MOD_Naivety
		TrainHumiliation(amount)
		return 2
	elseif x < MOD_Humility+MOD_Fearfulness+MOD_Naivety+MOD_Forgiveness
		TrainAnger(amount)
		return 3
	elseif x < MOD_Humility+MOD_Fearfulness+MOD_Naivety+MOD_Forgiveness+MOD_Prudent
		TrainResignation(amount)
		return 4
	endif
	TrainRespect(amount)
	return 5
EndFunction

int Function TrainForVampireFed(Actor akAbuser)
	string abuser_name 
	float amount
	if akAbuser == PlayerRef || akAbuser == None
		abuser_name = PlayerRef.GetDisplayName()
		amount = 10.0
	else
		abuser_name = akAbuser.GetDisplayName()
		amount = 5.0
	endif
	int hexaco_trait = TrainRandom(amount)
	if hexaco_trait == 0
		SendNotification(abuser_name+" feeds on a docile "+name)
	elseif hexaco_trait == 1
		SendNotification(abuser_name+" feeds on a shaking "+name)
	elseif hexaco_trait == 2
		SendNotification(abuser_name+" feeds on an innocent "+name)
	elseif hexaco_trait == 3
		SendNotification(abuser_name+" feeds on a tamed "+name)
	elseif hexaco_trait == 3
		SendNotification(abuser_name+" feeds on a flaccid "+name)
	else
		SendNotification(abuser_name+" feeds on a compliant "+name)
	endif
	if DOM01.DLC1ThrallFaction != None && akRef.IsInFaction(DOM01.DLC1ThrallFaction)
		if !DOM01.VampireCattleToggle
			akRef.RemoveFromFaction(DOM01.DLC1ThrallFaction)
		endif
	endif
	return hexaco_trait
EndFunction

Function TrainForVampireFeed(Actor akVictim)
	if akVictim == NONE
		return
	endif
	TrainSkillPredator(2.0)
	string victim_name 
	int hexaco_trait
	DOM_Actor akActor = DOM01.GetActor(akVictim)
	if akActor == None
		victim_name = akVictim.GetDisplayName()
		hexaco_trait = DOM01.DOMNPCTrainingRandom(akVictim,5.0)
	else
		victim_name = akActor.GetName()
		hexaco_trait = akActor.mind.TrainForVampireFed(akRef)
	endif
	if hexaco_trait == 0
		SendNotification(name+" feeds on a docile "+victim_name)
	elseif hexaco_trait == 1
		SendNotification(name+" feeds on a shaking "+victim_name)
	elseif hexaco_trait == 2
		SendNotification(name+" feeds on an innocent "+victim_name)
	elseif hexaco_trait == 3
		SendNotification(name+" feeds on a tamed "+victim_name)
	elseif hexaco_trait == 3
		SendNotification(name+" feeds on a flaccid "+victim_name)
	else
		SendNotification(name+" feeds on a compliant "+victim_name)
	endif
EndFunction

Function TrainBroken()
	DOM01.DOMPlayerAlias.HasBroken(actor_alias)
	;PrintTrainingBefore("mood",10.0,"broken")
	TrainSubmission(10.0)
	TrainHumiliation(10.0)
	TrainResignation(10.0)
	TrainFear(10.0)
	TrainAnger(20.0)
	TrainRespect(10.0)
	;PrintTrainingAfter("mood",10.0,"broken")
EndFunction
 
Function TrainInLove()
	;PrintTrainingBefore("mood",30.0,"inlove")
	is_love_interest = true
	if submission < 100.0
		TrainSubmission(30.0)
	endif
	if humiliation < 100.0
		TrainHumiliation(30.0)
	endif
	if resignation < 100.0
		TrainResignation(30.0)
	endif
	if respect_training < 100.0
		TrainRespect(30.0)
	endif
	if fear_training < 100.0
		TrainFear(30.0)
	endif
	if anger_training < 100.0
		TrainAnger(30.0)
	endif
	TrainAnal(30.0)
	TrainVaginal(30.0)
	TrainOral(30.0)
	RegisterForUpdateTrainingStatus()
	;PrintTrainingAfter("mood",30.0,"inlove")
EndFunction

State inlove
	Function StartMood()
		mood_swing_max *= 3
		SendNotificationActionMaster(name+" "+actorBeVerb+" in love with ","")
		LogTrace("mood=inlove start "+mood_swing_ticks+"/"+mood_swing_max)
		number_of_brainwashed += 1
		akRef.SetFactionRank(DOM01.DOMMoodInlove,1)
		TrainInLove()
		ClearLastPunishmentReason()
		actor_alias.TurnOffCrimeFaction()
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(10,100) ; Mood happy expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodInlove)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		SetExpressionByMood()
		actor_alias.TryRemoveTears(1)
		ChooseMoodSpontaneousOnTick(0.1)
	EndFunction

	Function OnMoodUpdate()
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.15)
			mood = "shock"
		elseif RandomFloat() < (__chance_jealous * 0.1)
			mood = "jealous"
		elseif RandomFloat() < (__chance_depressed * 0.1)
			mood = "depressed"
		elseif RandomFloat() < (__chance_insecure * 0.1)
			mood = "insecure"
		else
			ChooseIdle()
		endif
	EndEvent
		
	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		ChooseIdle()
	EndEvent

	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		return 2.0*MOD_Anxiety
	EndFunction

	float Function getRapeMultiplier()
		return 2.0*MOD_Liveliness
	EndFunction

	float Function getPraiseMultiplier()
		return 2.0*MOD_Organized
	EndFunction

	float Function getScoldMultiplier()
		return 2.0*MOD_Laborious
	EndFunction

	float Function getFeelingMultiplier() ; How much this mood affects emotions wrt training
		return 2.0*MOD_Sociability ; inlove, feelings, dominated by training
	EndFunction

	float Function getEmotionMultiplier() ; How much this mood affects emotions wrt training
		return MOD_Panic ; inlove, so tries to lower emotions
	EndFunction

	float Function getArousalBonus()
		return 0.25
	EndFunction

	Float Function RunAwayMoodBase()
		return 0.01
	EndFunction

	Float Function StopWaitingMoodBase()
		return 0.1-fear_training / 1000.0
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; slave is inlove
		if is_slave && RandomFloat()*83.3 < __total_training
			actor_alias.Anim_Salute()	
			AddNextPraiseReason(1) ; "being a good slave"
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction

	Function ChooseTopic()
		actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodInlove,PlayerRef)
	EndFunction

	Event OnToldOff(int ireason)
		ChooseMoodSpontaneous(0.1)
		ChooseIdle()
	EndEvent

	bool Function IsDevoted()
		return true
	EndFunction

	bool Function IsInLove()
		return true
	EndFunction

	bool Function MakeRunAway()
		return false
	EndFunction

	bool Function MakeRunAwayGang(float xfriendship)
		return false
	EndFunction

    string Function GetMoodName()
		return "in love"
    EndFunction

    string Function GetMoodNameThirdPerson()
		return "a loving "
    EndFunction

	int Function GetMoodIndex()
		return 14 ; "inlove"
	EndFunction

	Function SetRelationshipToPlayer()
		akRef.setRelationshipRank(PlayerRef, 4)
	EndFunction
EndState

State depressed
	Function StartMood()
		mood_swing_max *= 2
		SendNotificationAction(name+" "+actorBeVerb+" feeling down")
		LogTrace("mood=depressed start "+mood_swing_ticks+"/"+mood_swing_max)
		akRef.SetFactionRank(DOM01.DOMMoodSad,3)
		akRef.SetFactionRank(DOM01.DOMMoodInlove,2)
		akRef.AddToFaction(DOM01.DOMTobeComfortedFaction)
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(11,80) ; Mood sad expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodSad)
		akRef.RemoveFromFaction(DOM01.DOMMoodInlove)
		if !actor_alias.hasTears()
			akRef.RemoveFromFaction(DOM01.DOMTobeComfortedFaction)
		endif
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if ! RecoverFrom()
			SetExpressionByMood()
			TrySadnessTears()
			ChooseMoodSpontaneousOnTick(0.1)
		endif
	EndFunction

	Function OnMoodUpdate()
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.25)
			mood = "shock"
		elseif MakeMoodAfraid(0.05)
			;SetMoodAfraid()
		elseif MakeMoodAshamed(0.025)
			;SetMoodAshamed()
		elseif MakeMoodAngry(0.1)
			;SetMoodAngry
		elseif RandomFloat() < (__chance_insecure * 0.05)
			mood = "insecure"
		elseif RandomFloat() < (__chance_jealous * 0.05)
			mood = "jealous"
		elseif RandomFloat() < 0.5 && RandomFloat() < MOD_Prudent
			MakeCry()
		else
			ChooseIdle()
		endif
	EndEvent
	
	Event OnEndPunishment(Float severity)
		; extra resignation training
		TrainResignation(severity * 0.1)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		float xs = __chance_inlove
		if had_orgasm && RandomFloat() < xs
			mood = "inlove"
		elseif __is_aroused_for > 0 && RandomFloat() < xs*0.5
			mood = "inlove"
		elseif RandomFloat() < xs* 0.25
			mood = "inlove"
		elseif RandomFloat() < 0.5 && RandomFloat() < MOD_Prudent
			MakeCry()
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		Float chance = __chance_recover_from_depressed*__chance_recently_punished
		;LogTrace("recover depressed chance="+chance)
		if RandomFloat() < chance
			ChooseMoodSpontaneous(1.0)
			if mood == "depressed"
				mood = "inlove"
			endif
			return true
		endif
		return false
	EndFunction

	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		if is_oral
			return 3.0*MOD_Anxiety
		else
			return 0.5*MOD_Anxiety
		endif
	EndFunction

	float Function getPainMultiplier()
		return 2.0*MOD_Sincerity
	EndFunction

	float Function getRapeMultiplier()
		return 0.5*MOD_Liveliness
	EndFunction

	float Function getScoldMultiplier()
		return 3.0*MOD_Laborious
	EndFunction

	float Function getFeelingMultiplier() ; How much this mood affects emotions wrt training
		return 0.1*MOD_Sociability ; depressed, feelings, not dominated by training
	EndFunction

	float Function getEmotionMultiplier() ; How much this mood affects emotions wrt training
		return 3.0*MOD_Panic ; depressed, higher emotions
	EndFunction

	float Function getArousalBonus()
		return 0.25
	EndFunction

	Float Function RunAwayMoodBase()
		return 0.001
	EndFunction

	Float Function StopWaitingMoodBase()
		return 0.01-fear_training / 10000.0
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; slave is inlove and depressed
		if RandomFloat() < MOD_Prudent
			actor_alias.Anim_Cries()
			SetNextPunishmentReasonSilent(4) ; "crying"
			SetNextPraiseReasonSilent(4) ; "crying"
		elseif is_slave && RandomFloat()*83.3 < __total_training
			actor_alias.Anim_Salute()	
			AddNextPraiseReason(1) ; "being a good slave"
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction

	Function ChooseTopic()
		actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodDepressed,PlayerRef)
	EndFunction

	Event OnToldOff(int ireason)
		ChooseMoodSpontaneous(0.1)
		ChooseIdle()
	EndEvent

	bool Function IsDevoted()
		return true
	EndFunction

	bool Function IsInLove()
		return true
	EndFunction

	bool Function MakeRunAway()
		return false
	EndFunction

	bool Function MakeRunAwayGang(float xfriendship)
		return false
	EndFunction

	bool Function IsSad()
		return true
	EndFunction

	bool Function IsCrying()
		return true
	EndFunction

    string Function GetMoodName()
		return "not happy"
    EndFunction

    string Function GetMoodNameThirdPerson()
		return "an unhappy "
    EndFunction

	int Function GetMoodIndex()
		return 15 ; "depressed"
	EndFunction

	Function SetRelationshipToPlayer()
		akRef.setRelationshipRank(PlayerRef, 4)
	EndFunction
EndState

State insecure
	Function StartMood()
		mood_swing_max *= 2
		SendNotificationAction(name+" "+actorBeVerb+" feeling unwanted")
		LogTrace("mood=insecure start "+mood_swing_ticks+"/"+mood_swing_max)
		akRef.SetFactionRank(DOM01.DOMMoodAshamed,3)
		akRef.SetFactionRank(DOM01.DOMMoodInlove,4)
		akRef.AddToFaction(DOM01.DOMTobeComfortedFaction)
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(13,80) ; Mood puzzled expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodAshamed)
		akRef.RemoveFromFaction(DOM01.DOMMoodInlove)
		if !actor_alias.hasTears()
			akRef.RemoveFromFaction(DOM01.DOMTobeComfortedFaction)
		endif
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if ! RecoverFrom()
			SetExpressionByMood()
			TryShameTears()
			ChooseMoodSpontaneousOnTick(0.1)
		endif
	EndFunction

	Function OnMoodUpdate()
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.25)
			mood = "shock"
		elseif MakeMoodAfraid(0.05)
			;SetMoodAfraid()
		elseif MakeMoodAngry(0.025)
			;SetMoodAngry
		elseif MakeMoodSad(0.1)
			;SetMoodSad()
		elseif RandomFloat() < (__chance_depressed * 0.05)
			mood = "depressed"
		elseif RandomFloat() < (__chance_jealous * 0.05)
			mood = "jealous"
		elseif RandomFloat() < 0.5 && RandomFloat() < MOD_Anxiety
			MakeAshamed()
		else
			ChooseIdle()
		endif
	EndEvent
	
	Event OnEndPunishment(Float severity)
		; extra humiliation training
		TrainHumiliation(severity * 0.1)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		float xs = __chance_inlove
		if had_orgasm && RandomFloat() < xs
			mood = "inlove"
		elseif __is_aroused_for > 0 && RandomFloat() < xs*0.5
			mood = "inlove"
		elseif RandomFloat() < xs* 0.25
			mood = "inlove"
		elseif RandomFloat() < 0.5 && RandomFloat() < MOD_Prudent
			MakeAshamed()
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		Float chance = __chance_recover_from_insecure*__chance_recently_punished
		;LogTrace("recover insecure chance="+chance)
		if RandomFloat() < chance
			ChooseMoodSpontaneous(1.0)
			if mood == "insecure"
				mood = "inlove"
			endif
			return true
		endif
		return false
	EndFunction

	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		if is_vaginal
			return 3.0*MOD_Anxiety
		else
			return 0.5*MOD_Anxiety
		endif
	EndFunction

	float Function getRapeMultiplier()
		return 2.0*MOD_Liveliness
	EndFunction

	float Function getScoldMultiplier()
		return 0.5*MOD_Laborious
	EndFunction

	float Function getPraiseMultiplier()
		return 3.0*MOD_Organized
	EndFunction

	float Function getFeelingMultiplier() ; How much this mood affects emotions wrt training
		return 0.1*MOD_Sociability ; insecure, feelings, not dominated by training
	EndFunction

	float Function getEmotionMultiplier() ; How much this mood affects emotions wrt training
		return 3.0*MOD_Panic ; insecure, higher emotions
	EndFunction

	float Function getArousalBonus()
		return 0.5
	EndFunction

	Float Function RunAwayMoodBase()
		return 0.001
	EndFunction

	Float Function StopWaitingMoodBase()
		return 0.1-fear_training / 5000.0
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; slave is inlove and depressed
		if RandomFloat() < MOD_Naivety
			 TryCoverSelf()
		elseif is_slave && RandomFloat()*83.3 < __total_training
			actor_alias.Anim_Salute()	
			AddNextPraiseReason(1) ; "being a good slave"
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction

	Function ChooseTopic()
		actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodInsecure,PlayerRef)
	EndFunction

	Event OnToldOff(int ireason)
		ChooseMoodSpontaneous(0.1)
		ChooseIdle()
	EndEvent

	bool Function IsDevoted()
		return true
	EndFunction

	bool Function IsInLove()
		return true
	EndFunction

	bool Function IsAshamed()
		return true
	EndFunction

	bool Function MakeRunAway()
		return false
	EndFunction

	bool Function MakeRunAwayGang(float xfriendship)
		return false
	EndFunction

    string Function GetMoodName()
		return "insecure"
    EndFunction

    string Function GetMoodNameThirdPerson()
		return "an insecure "
    EndFunction

	int Function GetMoodIndex()
		return 16 ; "insecure"
	EndFunction

	Function SetRelationshipToPlayer()
		akRef.setRelationshipRank(PlayerRef, 4)
	EndFunction
EndState

State jealous
	Function StartMood()
		mood_swing_max *= 2
		SendNotificationAction(name+" is feeling annoyed")
		LogTrace("mood=jealous start "+mood_swing_ticks+"/"+mood_swing_max)
		akRef.SetFactionRank(DOM01.DOMMoodAngry,3)
		akRef.SetFactionRank(DOM01.DOMMoodInlove,3)
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(8,80) ; Mood anger expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodAngry)
		akRef.RemoveFromFaction(DOM01.DOMMoodInlove)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if ! RecoverFrom()
			SetExpressionByMood()
			actor_alias.TryRemoveTears(1)
			ChooseMoodSpontaneousOnTick(0.1)
		endif
	EndFunction

	Function OnMoodUpdate()
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if MakeMoodAfraid(0.05)
			;SetMoodAfraid()
		elseif MakeMoodSad(0.025)
			;SetMoodSad()
		elseif MakeMoodAshamed(0.1)
			;SetMoodAshamed()
		elseif RandomFloat() < (__chance_insecure * 0.05)
			mood = "insecure"
		elseif RandomFloat() < (__chance_depressed * 0.05)
			mood = "depressed"
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndPunishment(Float severity)
		; extra guilt training
		TrainAnger(severity * 0.1*MOD_Gentleness)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent
	
	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		float xs = __chance_inlove
		if had_orgasm && RandomFloat() < xs
			mood = "inlove"
		elseif __is_aroused_for > 0 && RandomFloat() < xs*0.5
			mood = "inlove"
		elseif RandomFloat() < xs* 0.25
			mood = "inlove"
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		Float chance = __chance_recover_from_jealous*__chance_recently_punished
		;LogTrace("Recover jealous chance="+chance)
		if RandomFloat() < chance
			ChooseMoodSpontaneous(1.0)
			if mood == "jealous"
				mood = "inlove"
			endif
			return true
		endif
		return false
	EndFunction

	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		if is_anal
			return 3.0*MOD_Anxiety
		else
			return 0.5*MOD_Anxiety
		endif
	EndFunction

	float Function getPainMultiplier()
		return 0.5*MOD_Sincerity
	EndFunction

	float Function getRapeMultiplier()
		return 3.0*MOD_Liveliness
	EndFunction

	float Function getPraiseMultiplier()
		return 0.5*MOD_Organized
	EndFunction

	float Function getFeelingMultiplier() ; How much this mood affects emotions wrt training
		return 0.1*MOD_Sociability ; annoyed, feelings, not dominated by training
	EndFunction

	float Function getEmotionMultiplier() ; How much this mood affects emotions wrt training
		return 3.0*MOD_Panic ; annoyed, higher emotions
	EndFunction

	float Function getArousalBonus()
		return 0.25
	EndFunction

	Float Function RunAwayMoodBase()
		return 0.05
	EndFunction

	Float Function StopWaitingMoodBase()
		return 0.15-fear_training / 1000.0
	EndFunction

	Float Function BreakRestraintMoodBase()
		return 0.1
	EndFunction

	Float Function StopOrderMoodBase(float training)
		return (0.25-( training / 400.0 ))+(0.25-( anger_training / 400.0 ))
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; slave is inlove and jealous
		if RandomFloat() < MOD_Dependence
			actor_alias.Anim_CrossArms()
			SetNextPunishmentReasonSilent(11) ; "being jealous"
		elseif is_slave && RandomFloat()*83.3 < __total_training
			actor_alias.Anim_Salute()	
			AddNextPraiseReason(1) ; "being a good slave"
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction

	Function ChooseTopic()
		actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodJealous,PlayerRef)
	EndFunction

	Event OnToldOff(int ireason)
		ChooseMoodSpontaneous(0.1)
		ChooseIdle()
	EndEvent

	bool Function IsDevoted()
		return true
	EndFunction

	bool Function IsInLove()
		return true
	EndFunction

	bool Function IsAngry()
		return true
	EndFunction

	bool Function MakeRunAway()
		return false
	EndFunction

	bool Function MakeRunAwayGang(float xfriendship)
		return false
	EndFunction

    string Function GetMoodName()
		return "annoyed"
    EndFunction

    string Function GetMoodNameThirdPerson()
		return "a jealous "
    EndFunction

	int Function GetMoodIndex()
		return 17 ; "jealous"
	EndFunction

	Function SetRelationshipToPlayer()
		akRef.setRelationshipRank(PlayerRef, 4)
	EndFunction
EndState

State defiant
	Function StartMood()
		mood_swing_max *= 2
		LogTrace("mood=defiant start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" "+actorBeVerb+" defiant")
		akRef.SetFactionRank(DOM01.DOMMoodAngry,2)
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(8,60) ; Mood angry expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodAngry)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if !MakeRunAway()
			if !RecoverFrom()
				SetExpressionByMood()
				actor_alias.TryRemoveTears(1)
				ChooseMoodSpontaneousOnTick(0.1)
			endif
		endif
	EndFunction

	Function OnMoodUpdate()
		if !actor_alias.is_moving && RandomFloat() < 0.05
			ChooseIdle()
		endif
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.1)
			mood = "shock"
		elseif RandomFloat() < (__chance_broken * 0.05)
			mood = "broken"
		elseif MakeMoodSad(0.15)
			;SetMoodSad()
		elseif MakeMoodAfraid(0.15)
			;SetMoodAfraid()
		elseif MakeMoodAshamed(0.5)
			;SetMoodAshamed()
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndPunishment(Float severity)
		; extra guilt training
		TrainAnger(severity * 0.1*MOD_Gentleness)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if had_orgasm && MakeMoodAshamed(1.0)
			;SetMoodAshamed()
		elseif __is_aroused_for > 0 && MakeMoodAshamed(0.5)
			;SetMoodAshamed()
		elseif MakeMoodAshamed(0.25)
			;SetMoodAshamed()
		elseif RandomFloat() < (__chance_broken * 0.05)
			mood = "broken"
		elseif !(__is_aroused_for > 0) && MakeMoodSad(0.15)
			;SetMoodSad()
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		Float chance = __chance_recover_from_angry*__chance_recently_punished_inverted
		;LogTrace("recover defiant chance="+chance)
		if RandomFloat() < chance
			ChooseMoodChange()
			return true
		endif
		return false
	EndFunction
	
	float Function getRapeMultiplier()
		return 1.5*MOD_Liveliness
	EndFunction
	
	float Function getFeelingMultiplier()
		return 1.25*MOD_Sociability ; angry thinking
	EndFunction

	float Function getEmotionMultiplier() 
		return 0.75*MOD_Panic ; angry thinking
	EndFunction

	float Function getPainMultiplier()
		return 0.5*MOD_Sincerity
	EndFunction
	
	float Function getScoldMultiplier()
		return 1.5*MOD_Laborious
	EndFunction

	float Function getPraiseMultiplier()
		return 0.5*MOD_Organized
	EndFunction

	Float Function RunAwayMoodBase()
		return 2.0
	EndFunction

	Float Function CallForHelpMoodBase()
		return 2.0
	EndFunction
	
	Float Function StopWaitingMoodBase()
		return 0.5-respect_training / 200.0
	EndFunction

	Float Function BreakRestraintMoodBase()
		return 0.9
	EndFunction

	Float Function StopOrderMoodBase(float training)
		return (0.5-( training / 200.0 ))+(0.5-( respect_training / 200.0 ))
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; Slave is angry
		if RandomFloat() > MOD_Rebellion && RandomFloat()*100.0 > respect_training
			actor_alias.Anim_AggressiveGesture()
			was_respectful = false
			SetNextPunishmentReasonSilent(13) ; "being disrespectful"
		elseif RandomFloat() < MOD_Resentment
			actor_alias.Anim_CrossArms()
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction
	
	Function ChooseTopic()
		bool not_respectful = IsNotRespectful(1.3)
		if not_respectful
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodAngry,PlayerRef)
		else
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodAngryRespectful,PlayerRef)
		endif
	EndFunction

	Event OnToldOff(int ireason)
		ChooseMoodSpontaneous(0.1)
		ChooseIdle()
	EndEvent

	bool Function IsObedient()
		if timer_obedient > 0 || RandomFloat() < MOD_Authority || RandomFloat()*100.0 < respect_training
			return true
		endif
		return false
	EndFunction

	bool Function IsAngry()
		return true
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "a rebellious "
    EndFunction

	int Function GetMoodIndex()
		return 18 ; "defiant"
	EndFunction

	Function SetRelationshipToPlayer()
		if akRef.getRelationshipRank(PlayerRef) > -(2)
			akRef.setRelationshipRank(PlayerRef, akRef.getRelationshipRank(PlayerRef) - 1)
		endif
	EndFunction
EndState

State crushed
	Function StartMood()
		mood_swing_max *= 2
		LogTrace("mood=crushed start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" "+actorBeVerb+" crushed")
		akRef.SetFactionRank(DOM01.DOMMoodSad,2)
		akRef.AddToFaction(DOM01.DOMTobeComfortedFaction)
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(11,100) ; Mood sad expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodSad)
		if !actor_alias.hasTears()
			akRef.RemoveFromFaction(DOM01.DOMTobeComfortedFaction)
		endif
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if !MakeRunAway()
			if ! RecoverFrom()
				SetExpressionByMood()
				TrySadnessTears()
				ChooseMoodSpontaneousOnTick(0.1)
			endif
		endif
	EndFunction

	Function OnMoodUpdate()
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.1)
			mood = "shock"
		elseif RandomFloat() < (__chance_broken * 0.05)
			mood = "broken"
		elseif MakeMoodAngry(0.15)
			;SetMoodAngry
		elseif MakeMoodAfraid(0.15)
			;SetMoodAfraid()
		elseif RandomFloat() < (__chance_proud * 0.2)
			mood = "proud"
		elseif RandomFloat() < 0.5 && RandomFloat() < MOD_Prudent
			MakeCry()
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndPunishment(Float severity)
		; extra resignation training
		TrainHumiliation(severity * 0.1)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if RandomFloat() < (__chance_shock * 0.25)
			mood = "shock"
			return
		endif
		if had_orgasm && MakeMoodAshamed(1.0)
			;SetMoodAshamed()
			return
		endif
		float xs = __chance_proud
		if __is_aroused_for > 0 && RandomFloat() < xs*0.25
			mood = "proud"
		elseif RandomFloat() < xs* 0.1
			mood = "proud"
		elseif RandomFloat() < (__chance_broken * 0.05)
			mood = "broken"
		elseif RandomFloat() < 0.5 && RandomFloat() < MOD_Prudent
			MakeCry()
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		Float chance = __chance_recover_from_sad*__chance_recently_punished_inverted
		;LogTrace("recover sad chance="+chance)
		if RandomFloat() < chance
			ChooseMoodChange()
			return true
		endif
		return false
	EndFunction

	float Function getPainMultiplier()
		return 1.5*MOD_Sincerity
	EndFunction

	float Function getScoldMultiplier()
		return 1.5*MOD_Laborious
	EndFunction

	float Function getPraiseMultiplier()
		return 0.5*MOD_Organized
	EndFunction
	
	float Function getRapeMultiplier()
		return 1.5*MOD_Liveliness
	EndFunction

	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		if is_oral
			return 1.2*MOD_Anxiety
		endif
		return MOD_Anxiety
	EndFunction
	
	Float Function RunAwayMoodBase()
		return 0.10
	EndFunction

	Float Function CallForHelpMoodBase()
		return 0.10
	EndFunction
	
	Float Function StopWaitingMoodBase()
		return 0.25-fear_training / 400.0
	EndFunction

	Float Function BreakRestraintMoodBase()
		return 0.1
	EndFunction

	Float Function StopOrderMoodBase(float training)
		return (0.5-( training / 200.0 ))
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; Slave is sad
		if RandomFloat() < MOD_Prudent
			actor_alias.Anim_Cries()
			SetNextPunishmentReasonSilent(4) ; "crying"
			SetNextPraiseReasonSilent(4) ; "crying"
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction

	Function ChooseTopic()
		bool not_respectful = IsNotRespectful(1.1)
		if not_respectful
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodSad,PlayerRef)
		else
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodSadRespectful,PlayerRef)
		endif
	EndFunction

	bool Function IsObedient()
		if timer_obedient > 0 || RandomFloat() < MOD_Prudent || RandomFloat()*100.0 < resignation
			return true
		endif
		return false
	EndFunction

	bool Function IsSad()
		return true
	EndFunction

	bool Function IsCrying()
		return true
	EndFunction

	bool Function IsShocked()
		return true
	EndFunction
	
    string Function GetMoodNameThirdPerson()
		return "a weeping "
    EndFunction

	int Function GetMoodIndex()
		return 19 ; "crushed"
	EndFunction

	Function SetRelationshipToPlayer()
		akRef.setRelationshipRank(PlayerRef, -(1))
	EndFunction
EndState

State proud
	Function StartMood()
		mood_swing_max *= 2
		LogTrace("mood=proud start "+mood_swing_ticks+"/"+mood_swing_max)
		SendNotificationAction(name+" "+actorBeVerb+" proud")
		akRef.SetFactionRank(DOM01.DOMMoodAshamed,2)
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(14,80) ; Mood disgusted expression
	EndFunction

	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodAshamed)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		if !MakeRunAway()
			if !RecoverFrom()
				SetExpressionByMood()
				ChooseMoodSpontaneousOnTick(0.1)
			endif
		endif
	EndFunction

	Function OnMoodUpdate()
	EndFunction

	bool Function IsAshamed()
		return true
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if MakeMoodAngry(0.1)
			;SetMoodAngry
		elseif MakeMoodAfraid(0.05)
			;SetMoodAfraid()
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndPunishment(Float severity)
		; extra humiliation training
		TrainHumiliation(severity * 0.1)
		if !actor_alias.CanTalk() && !WillTalkUnderPain()
			return
		endif
		ChooseTopic()
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		if RandomFloat() < (__chance_shock * 0.25)
			mood = "shock"
			return
		endif
		if MakeMoodAngry(0.1)
			;SetMoodAngry
		elseif MakeMoodAfraid(0.05)
			;SetMoodAfraid()
		else	
			ChooseIdle()
		endif
	EndEvent

	bool Function RecoverFrom()
		if mood_swing_ticks <= mood_swing_max
			return false
		endif
		Float chance = __chance_recover_from_ashamed * __chance_recently_punished_inverted
		;LogTrace("recover ashamed chance="+chance)
		if RandomFloat() < chance
			ChooseMoodChange()
			return true
		endif
		return false
	EndFunction
	
	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		return 1.5*MOD_Anxiety
	EndFunction

	float Function getRapeMultiplier()
		return 2.0*MOD_Liveliness
	EndFunction

	float Function getPainMultiplier()
		return 1.5*MOD_Sincerity
	EndFunction

	float Function getArousalBonus()
		return 0.2
	EndFunction
	
	Float Function RunAwayMoodBase()
		return 0.6
	EndFunction
	
	Float Function StopWaitingMoodBase()
		return 0.5-fear_training / 200.0
	EndFunction

	Float Function BreakRestraintMoodBase()
		return 0.4
	EndFunction

	Float Function StopOrderMoodBase(float training)
		return (0.8-( training / 125.0 ))
	EndFunction

	Function ChooseIdle()
		if (!actor_alias.canIdle)
			return
		endif 
		; Slave is proud
		if RandomFloat() < MOD_SelfEsteem && RandomFloat()*100.0 < humiliation
			actor_alias.Anim_CrossArms()
		else
			ChooseDefaultIdle()
		endif
		ChooseDrunkIdle()
	EndFunction

	Function ChooseTopic()
		bool not_respectful = IsNotRespectful(0.5)
		if not_respectful
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodAshamed,PlayerRef)
		else
			actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodAshamedRespectful,PlayerRef)
		endif
	EndFunction

	bool Function IsObedient()
		if timer_obedient > 0 || RandomFloat() > MOD_SelfEsteem || RandomFloat()*200.0 < humiliation
			return true
		endif
		return false
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "a proud "
    EndFunction

	int Function GetMoodIndex()
		return 20 ; "proud"
	EndFunction

	Function SetRelationshipToPlayer()
		akRef.setRelationshipRank(PlayerRef, -(1))
	EndFunction
EndState

State charmed
	Function StartMood()
		LogTrace("mood=charmed start "+mood_swing_ticks+"/"+mood_swing_max)
		mood_swing_max *= 3
		SendNotificationAction(name+" "+actorBeVerb+" charmed")
		akRef.SetFactionRank(DOM01.DOMMoodHappy,3)
		akRef.SetFactionRank(DOM01.DOMMoodInlove,0)
		TrainInLove()
		ClearLastPunishmentReason()
		actor_alias.TurnOffCrimeFaction()
		SetRelationshipToPlayer()
		SetExpressionByMood()
		ChooseIdle()
	EndFunction

	Function SetExpressionByMood()
		SetExpression(10,100) ; Mood happy expression
	EndFunction
	
	Function EndMood()
		akRef.RemoveFromFaction(DOM01.DOMMoodHappy)
		akRef.RemoveFromFaction(DOM01.DOMMoodInlove)
		ClearExpression()
	EndFunction

	Function OnMoodUpdateGameTime()
		mood_swing_ticks += 1
		SetExpressionByMood()
		actor_alias.TryRemoveTears(1)
		ChooseMoodSpontaneousOnTick(0.1)
	EndFunction

	Function ChooseIdle()
	EndFunction	

	Function ChooseTopic()
		actor_alias.SayTopic(DOM01.DOM02TopicAnswerMoodInlove,PlayerRef)
	EndFunction

	Event OnExperiencePain()
		mood_swing_ticks += 1
		if mood_swing_ticks <= mood_swing_max
			ChooseIdle()
			return
		endif
		if RandomFloat() < (__chance_shock * 0.15)
			mood = "shock"
		elseif RandomFloat() < (__chance_jealous * 0.1)
			mood = "jealous"
		elseif RandomFloat() < (__chance_depressed * 0.1)
			mood = "depressed"
		elseif RandomFloat() < (__chance_insecure * 0.1)
			mood = "insecure"
		else
			ChooseIdle()
		endif
	EndEvent

	Event OnEndSex(bool had_orgasm)
		mood_swing_ticks += 1
		ChooseIdle()
	EndEvent

	float Function getSexMultiplier(bool is_oral, bool is_vaginal, bool is_anal)
		return 2.0*MOD_Anxiety
	EndFunction

	float Function getRapeMultiplier()
		return 2.0*MOD_Liveliness
	EndFunction

	float Function getPraiseMultiplier()
		return 2.0*MOD_Organized
	EndFunction

	float Function getScoldMultiplier()
		return 2.0*MOD_Laborious
	EndFunction

	float Function getFeelingMultiplier() ; How much this mood affects emotions wrt training
		return 2.0*MOD_Sociability ; inlove, feelings, dominated by training
	EndFunction

	float Function getEmotionMultiplier() ; How much this mood affects emotions wrt training
		return MOD_Panic ; inlove, so tries to lower emotions
	EndFunction

	float Function getArousalBonus()
		return 0.25
	EndFunction

	bool Function IsInLove()
		return true
	EndFunction

	bool Function IsHappy()
		return true
	EndFunction

    string Function GetMoodNameThirdPerson()
		return "a charmed "
    EndFunction

	int Function GetMoodIndex()
		return 21 ; "charmed"
	EndFunction

	Function SetRelationshipToPlayer()
		if akRef.GetRelationshipRank(PlayerRef) < 4
			akRef.SetRelationshipRank(PlayerRef, 4)
		endif
	EndFunction
EndState

; ### Mood independant Functions 

Function ChooseDefaultIdle()
	; Mood independent idles - Do not call directly, call ChooseIdle()
	
	; Well trained slaves
	if is_slave && RandomFloat()*166.6 < __total_training
		actor_alias.Anim_Salute()	
		AddNextPraiseReason(1) ; "being a good slave"
	endif
	
	; Respectful Idles
	if should_be_respectful && RandomFloat() < MOD_Discipline
		actor_alias.Anim_LookDown()	
	elseif is_slave && should_be_respectful && RandomFloat()*83.3 > __total_training
		actor_alias.Anim_Salute()				
	elseif is_slave && last_praise_reason==1 && RandomFloat()*83.3 > __total_training ; "being a good slave"
		actor_alias.Anim_Salute()				
	elseif (is_slave && actor_alias.is_shamed) || IsAshamed()
		;LogTrace("is_shamed="+actor_alias.is_shamed+" IsAshamed="+IsAshamed()+" mood="+mood)
		actor_alias.Anim_Shamed()				
	elseif actor_alias.is_naked
		if !TryCoverSelf()
			TryWarmArms()
		endif
	elseif RandomFloat()*100.0 < respect_training && RandomFloat() < MOD_Authority
		actor_alias.Anim_LookDown()	
	endif
EndFunction

bool Function TryCoverSelf()
	if !IsFeelingAshamed()
		return false
	endif
	if actor_alias.is_running_away
		if WillObeyBecauseWarned(2) > 0 ; "covering self"
			SendNotificationAbuse(name+" goes about to cover "+actorObjective+"self but remembers your warning")	
			return false
	endif
	endif
	if actor_alias.Anim_CoverSelf()
		;LogTrace("TryCoverSelf: is feeling ashamed")
		SetNextPunishmentReasonSilent(2) ; "covering self"
	endif
	return true
EndFunction
	
int Function TryWearClothes()
	if IsObedient() || actor_alias.is_showering
		return 0
	endif
	if RandomFloat()*100.0 < humiliation
		return 0
	endif
	if IsScaredToObey()
		return 0
	endif
	if WillObeyBecauseWarned(2) > 0 ; "covering self"
		return -1
	endif
	return 1
EndFunction

Function TryWarmArms()
	if RandomFloat()*100.0 < submission
		return
	endif
	int weatherType = GetWeatherType(akRef)
	if weatherType < 2
		return
	endif
	float wMalus
	if weatherType > 2
		wMalus = 66.6
	elseif weatherType > 1
		wMalus = 33.3
	endif
	if RandomFloat()*100.0 + wMalus > FACET_Toughness
		;LogTrace("TryWarmArms: "+name+" weather type = "+weatherType)
		actor_alias.Anim_WarmArms() 
	endif
	return
EndFunction

Function TryRemoveTears(int amount)
	if RandomFloat() < 0.2
		actor_alias.TryRemoveTears(amount)
	endif
EndFunction

Function TryFearTears()
	if MOD_Prudent < 0.3
		 actor_alias.TryRemoveTears(1)
		 return
	endif
	if RandomFloat() < 0.1 && RandomFloat() < MOD_Prudent*0.5
		MakeCry()
	endif
EndFunction

Function TryShameTears()
	if MOD_Prudent < 0.15
		 actor_alias.TryRemoveTears(1)
		 return
	endif
	if RandomFloat() < 0.1 && RandomFloat() < MOD_Prudent*0.5
		MakeCry()
	endif
EndFunction

Function TrySadnessTears()
	if RandomFloat() < 0.1 && RandomFloat() < MOD_Prudent
		MakeCry()
	endif
EndFunction

Function TryDistressTears()
	if RandomFloat() < 0.2 && RandomFloat()-(0.1) < MOD_Prudent
		MakeCry()
	endif
EndFunction

; ### Mood swing
bool Function MoodSwingActive(float amount) ; first reaction moods
	float chance0 = __chance_afraid*amount
	float chance1 = __chance_angry*amount
	float chance2 = __chance_proud*amount
	float chance3 = __chance_defiant*amount

	if chance0 > chance1 && chance0 > chance2 && chance0 > chance3
		if MoodSwing("afraid",chance0) ; 0xx
			return true
		endif
		return MoodSwingThree("angry",chance1,"proud",chance2,"defiant",chance3)
	endif

	if chance1 > chance2 && chance1 > chance3
		if MoodSwing("angry",chance1) ; 1xx
			return true
		endif
		return MoodSwingThree("afraid",chance0,"proud",chance2,"defiant",chance3)
	endif

	if chance2 > chance3
		if MoodSwing("proud",chance2) ; 2xx
			return true
		endif
		return MoodSwingThree("afraid",chance0,"angry",chance1,"defiant",chance3)
	endif

	if MoodSwing("defiant",chance3) ; 3xx
		return true
	endif
	return MoodSwingThree("afraid",chance0,"angry",chance1,"proud",chance2)
EndFunction

bool Function MoodSwingPassive(float amount)
	float chance0 = __chance_scared*amount
	float chance1 = __chance_terrified*amount
	float chance2 = __chance_crushed*amount
	float chance3 = __chance_sad*amount
	float chance4 = __chance_ashamed*amount

	float chance_afraid
	if chance0 > chance1
		chance_afraid = chance0
	else
		chance_afraid = chance1
	endif
	
	if chance_afraid > chance2 && chance_afraid > chance3  && chance_afraid > chance4
		if MoodSwingTwo("scared",chance0,"terrified",chance1) ; 1xx & 2xx
			return true
		endif
		return MoodSwingThree("crushed",chance2,"sad",chance3,"ashamed",chance4)
	endif

	if chance2 > chance3  && chance2 > chance4
		if MoodSwing("crushed",chance2) ; 3xx
			return true
		endif
		if chance_afraid > chance3 && chance_afraid > chance4
			if MoodSwingTwo("scared",chance0,"terrified",chance1)
				return true
			endif
			return MoodSwingTwo("sad",chance3,"ashamed",chance4)
		endif
		if MoodSwingTwo("sad",chance3,"ashamed",chance4)
			return true
		endif
		return MoodSwingTwo("scared",chance0,"terrified",chance1)
	endif

	if chance3 > chance4
		if MoodSwing("sad",chance3) ; 3xx
			return true
		endif

		if chance_afraid > chance2 && chance_afraid > chance4
			if MoodSwingTwo("scared",chance0,"terrified",chance1)
				return true
			endif
			return MoodSwingTwo("crushed",chance2,"ashamed",chance4)
		endif
		if MoodSwingTwo("crushed",chance2,"ashamed",chance4)
			return true
		endif
		return MoodSwingTwo("scared",chance0,"terrified",chance1)
	endif

	if MoodSwing("ashamed",chance4) ; 4xx
		return true
	endif

	if chance_afraid > chance2 && chance_afraid > chance3
		if MoodSwingTwo("scared",chance0,"terrified",chance1)
			return true
		endif
		return MoodSwingTwo("crushed",chance2,"sad",chance3)
	endif
	if MoodSwingTwo("crushed",chance2,"sad",chance3)
		return true
	endif
	return MoodSwingTwo("scared",chance0,"terrified",chance1)
EndFunction

bool Function MoodSwingThree(string mood_swing1, float x1, string mood_swing2, float x2, string mood_swing3, float x3)
	;LogTrace("MoodSwingThree() change mood to "+mood_swing1+" "+x1+" or "+mood_swing2+" "+x2+" or "+mood_swing3+" "+x3)
	if x1 > x2 && x1 > x3 ; mood 1 dominates
		;LogTrace("MoodSwingThree() 1 "+mood_swing1+" "+x1+" "+x2+" "+x3)
		if x1 <= 0.0
			;LogTrace("MoodSwingThree() no change chance="+x1)
			return false
		endif
		if mood == mood_swing1
			;LogTrace("MoodSwingThree() same mood"+mood_swing1)
			return true ; no change
		elseif RandomFloat() < x1
			mood = mood_swing1
			return true
		else
			return MoodSwingTwo(mood_swing2,x2,mood_swing3,x3)
		endif
	elseif x2 > x1 && x2 > x3 ; mood 2 dominates
		;LogTrace("MoodSwingThree() 2 "+mood_swing2+" "+x1+" "+x2+" "+x3)
		if x2 <= 0.0
			;LogTrace("MoodSwingThree() no change chance="+x2)
			return false
		endif
		if mood == mood_swing2
			;LogTrace("MoodSwingThree() same mood"+mood_swing2)
			return true ; no change
		elseif RandomFloat() < x2
			mood = mood_swing2
			return true
		else
			return MoodSwingTwo(mood_swing1,x1,mood_swing3,x3)
		endif
	else ; mood 3 dominates
		;LogTrace("MoodSwingThree() 3 "+mood_swing3+" "+x1+" "+x2+" "+x3)
		if x3 <= 0.0
			return false
		endif
		if mood == mood_swing3
			;LogTrace("MoodSwingThree() same mood"+mood_swing3)
			return true ; no change
		elseif RandomFloat() < x3
			mood = mood_swing3
			return true
		else
			return MoodSwingTwo(mood_swing1,x1,mood_swing2,x2)
		endif
	endif
	;LogTrace("MoodSwingThree() new mood="+mood)
	return true ; mood has changed
EndFunction

bool Function MoodSwingTwo(string mood_swing1, float chance1, string mood_swing2, float chance2)
	;LogTrace("MoodSwingTwo() change mood to "+mood_swing1+" "+chance1+" or "+mood_swing2+" "+chance2)
	if chance1 > chance2
		if chance1 <= 0.0
			return false
		endif
		if MoodSwing(mood_swing1, chance1)
			return true
		endif
		return  MoodSwing(mood_swing2, chance2)
	endif
	if chance2 <= 0.0
		return false
	endif
	if MoodSwing(mood_swing2, chance2)
		return true
	endif
	return  MoodSwing(mood_swing1, chance1)
EndFunction
 
bool Function MoodSwing(string mood_swing, float chance)
	if chance <= 0.0
		return false
	endif
	if mood == mood_swing
		;LogTrace("MoodSwing() keep same mood "+mood_swing)
		return true
	endif
	float x = RandomFloat()
	if x < chance
		;LogTrace("MoodSwing() changing mood to "+mood_swing+" chance="+chance+" x="+x)
		mood = mood_swing
		return true
	endif
	;LogTrace("MoodSwing() NOT changing mood to "+mood_swing+" chance="+chance+" x="+x)
	return false
EndFunction

Function ChooseMoodChange()
	string previous_mood = mood
	ChooseMoodSpontaneous(1.0)
	if mood != previous_mood
		return
	endif
	if IsDevoted()
		mood = "inlove"
		return
	endif
	if !is_Slave
		mood = "neutral"
		return
	endif
	; Look for mood with highest chance
	float chance_fear = __chance_afraid
	if __chance_terrified > __chance_afraid
		chance_fear = __chance_terrified
	endif
	if __chance_scared > __chance_afraid
		chance_fear = __chance_scared
	endif
	float chance_anger = __chance_angry
	if __chance_defiant > chance_anger
		chance_anger = __chance_defiant
	endif
	float chance_cry = __chance_sad
	if __chance_crushed > chance_cry
		chance_cry = __chance_crushed
	endif
	float chance_shame = __chance_ashamed
	if __chance_proud > chance_shame
		chance_shame = __chance_proud
	endif
	
	float chance_max
	if !IsAfraid()
		chance_max = chance_fear
	endif
	if !IsAngry() && chance_anger > chance_max
		chance_max = chance_anger
	endif
	if !IsSad() && chance_cry > chance_max
		chance_max = chance_cry
	endif
	if IsAshamed() && chance_shame > chance_max
		chance_max = chance_shame
	endif
	if mood != "shock" && __chance_shock > chance_max
		chance_max = __chance_shock
	endif
	if mood != "broken" && __chance_broken > chance_max
		chance_max = __chance_broken
	endif
	
	; Choose mood
	if !IsAfraid() && chance_fear >= chance_max
		if __chance_afraid > __chance_terrified && __chance_afraid > __chance_scared
			mood = "afraid"
			return
		endif
		if __chance_terrified > __chance_afraid && __chance_terrified > __chance_scared
			mood = "terrified"
			return
		endif
		mood = "scared"
		return
	endif	
	if !IsAngry() && chance_anger >= chance_max
		if __chance_angry > __chance_defiant
			mood = "angry"
			return
		endif
		mood = "defiant"
		return
	endif
	if !IsSad() && chance_cry >= chance_max
		if __chance_sad > __chance_crushed
			mood = "sad"
			return
		endif
		mood = "crushed"
		return
	endif
	if !IsAshamed() && chance_shame >= chance_max
		if __chance_ashamed > __chance_proud
			mood = "ashamed"
			return
		endif
		mood = "proud"
		return
	endif
	if previous_mood != "shock" && __chance_shock >= chance_max
		mood = "shock"
		return
	endif
	if previous_mood != "broken" && __chance_broken >= chance_max
		mood = "broken"
		return
	endif
	mood = "neutral"
EndFunction

bool Function IsMoodSpontaneouslyPassive(float amount)
    ;*** Stage-1 Terrified (freezed by fear and sorrow - no solution found at stage 2, brain is frozen)
    ;*** Stage-2 Scared (fearful - stage 4 acceptance of fate)
    ;*** Stage-2 Ashamed (focusing on the instant, shame)
    ;*** Stage-2 Sad (computing and realizing there is no hope)
	;LogTrace("choose mood spontaneous PASSIVE")

	float chance = MOD_Manipulation*amount
	float x = RandomFloat()
	;LogTrace("IsMoodSpontaneouslyPassive() chance="+x+"/"+chance+" mod="+MOD_Manipulation+" amount="+amount)
	if x < chance
		return MoodSwingPassive(amount)
	endif
	return false
EndFunction

bool Function IsMoodSpontaneouslyActive(float amount)
    ;*** Stage-1 Fleeing=afraid (fear - stage 2 of reaction to stress)   
    ;--- Stage-1 Fighting=angry (anger - stage 2 of reaction to stress)
    ;*** Stage-2 Defiant (anger - trying to escape, stage 2 did not work as expected)
	;LogTrace("choose mood spontaneous ACTIVE")

	float chance = MOD_Impatience*amount
	float x = RandomFloat()
	;LogTrace("IsMoodSpontaneouslyActive() chance="+x+"/"+chance+" mod="+MOD_Impatience+" amount="+amount)
	if x < chance
		return MoodSwingActive(amount)
	endif
	return false
EndFunction

bool Function IsMoodSpontaneouslyNeutral(float amount)
    ;*** Stage-1 Neutral (assessing the situation - stage 1 of reaction to stress)
    ;--- Stage-3 InDenial (in denial of what's really happening after no solution found at stage 2)
    ;--- Stage-4 Recovering (resting and recovering from stress - stage 4 of reaction to stress)
    ;--- Stage-4 Thinking (revenge -HA = close to psycho)
	;LogTrace("choose mood spontaneous NEUTRAL")

	if is_slave
		if IsDevoted()
			amount *= 0.25
		else
			return false
		endif
	endif
	float chance = MOD_Rebellion*amount
	float x = RandomFloat()
	;LogTrace("IsMoodSpontaneouslyNeutral() chance="+x+"/"+chance+" mod="+MOD_Rebellion+" amount="+amount)
	if x < chance
		return MoodSwing("neutral",amount)
	endif
	return false
EndFunction

bool Function IsMoodSpontaneouslyCooperative(float amount)
    ;*** Shocked (ptsd) - MOD_Anxiety
    ;*** Broken  (1st stage of ss=survival instinct dictates to obey - stage 5)
    ;*** Loyal   (2nd stage of ss=survival instinct adopts abuser vision of the world)
    ;*** InLove  (3rd stage of ss=survival instinct confuses terror and love)
	;LogTrace("IsMoodSpontaneouslyCooperative() choose mood spontaneous COOPERATIVE START")

	; For non slaves
	if !is_slave
		;LogTrace("choose mood spontaneous COOPERATIVE: not a slave")
		float x0 = __chance_charmed * amount
		float x1 = __chance_inlove * amount
		float x2 = __chance_loyal * amount
		float x3 = __chance_happy * amount
		bool change_mood
		if x1 > x2
			change_mood = MoodSwingThree("happy",x3,"charmed",x0,"inlove",x1)
		else
			change_mood = MoodSwingThree("happy",x3,"charmed",x0,"loyal",x2)
		endif
		;LogTrace("choose mood spontaneous FREE "+x0+" "+x1+" "+x2+" "+x3+" now "+mood)
		if change_mood
			;LogTrace("choose mood spontaneous free 0 = "+mood)
			return true ; mood changed or stable
		endif
		if RandomFloat() < x0
			mood = "charmed"
			;LogTrace("choose mood spontaneous free 0 = "+mood)
			return true
		elseif RandomFloat() < x3
			mood = "happy"
			;LogTrace("choose mood spontaneous free 1 = "+mood)
			return true
		elseif RandomFloat()*0.25 < x3
			mood = "fine"
			;LogTrace("choose mood spontaneous free 2 = "+mood)
			return true
		elseif RandomFloat()*0.1 < x3
			mood = "neutral"
			;LogTrace("choose mood spontaneous free 3 = "+mood)
			return true
		endif
		;LogTrace("choose mood spontaneous COOPERATIVE: not a slave but not happy")
	elseif IsBrokenToObey() ; For broken slaves
		;LogTrace("choose mood spontaneous COOPERATIVE: broken slave")
		float x0 = __chance_charmed * amount
		float x1 = __chance_happy * amount
		float x2 = __chance_inlove * amount
		if x1 > x2 && x1 > x0 && RandomFloat() < x1
			mood = "happy"
			;LogTrace("choose mood spontaneous broken 0 = "+mood)
			return true
		elseif x0 > x2 && x0 > x1 && RandomFloat() < x0
			mood = "charmed"
			;LogTrace("choose mood spontaneous broken 0 = "+mood)
			return true
		endif
		float x3 = x1*4.0
		float x4 = __chance_loyal * amount
		if x3 > x4 && RandomFloat() < x3
			mood = "fine"
			;LogTrace("choose mood spontaneous broken 1 = "+mood)
			return true
		endif
		;LogTrace("choose mood spontaneous COOPERATIVE: broken slave but not happy")
	endif
	
	; Is there a chance for inlove/loyal/broken
	if number_of_shock != 0
		if number_of_praise != 0
			if number_of_sex != 0 || number_of_flatter != 0
				float x1 = __chance_inlove * amount
				float x2 = __chance_depressed * amount
				float x3 = __chance_jealous * amount
				float x4 = __chance_insecure * amount
				;LogTrace("choose mood spontaneous LOVING inlove="+x1+" "+x2+" "+x3+" "+x4+" was "+mood)
				bool change_mood
				if x4 < x2 && x4 < x3
					change_mood = MoodSwingThree("inlove",x1,"depressed",x2,"jealous",x3)
				elseif x3 < x2 && x3 < x4
					change_mood = MoodSwingThree("inlove",x1,"insecure",x4,"depressed",x2)
				else
					change_mood = MoodSwingThree("inlove",x1,"jealous",x3,"insecure",x4)
				endif
				;LogTrace("choose mood spontaneous cooperative LOVING "+x1+" "+x2+" "+x3+" "+x4+" now "+mood)
				if change_mood
					;LogTrace("choose mood spontaneous cooperative 0 = "+mood)
					return true ; mood changed or stable
				endif
				;LogTrace("choose mood spontaneous LOVING EXITING")
			endif
			if mood == "loyal"
				;LogTrace("choose mood spontaneous LOYAL stable")
				;LogTrace("choose mood spontaneous cooperative 1 = "+mood)
				return true ; no change
			elseif RandomFloat() < (__chance_loyal * amount)
				mood = "loyal"
				;LogTrace("choose mood spontaneous LOYAL "+mood)
				;LogTrace("choose mood spontaneous cooperative 2 = "+mood)
				return true
			endif
		endif
		if mood == "broken"
			;LogTrace("choose mood spontaneous BROKEN stable")
			;LogTrace("choose mood spontaneous cooperative 3 = "+mood)
			return true ; no change
		elseif RandomFloat() < (__chance_broken * amount)
			mood = "broken"
			;LogTrace("choose mood spontaneous BROKEN "+mood)
			;LogTrace("choose mood spontaneous cooperative 4 = "+mood)
			return true
		endif
	endif
	; Is there a chance for shock
	float chance = MOD_Anxiety
	;LogTrace("choose mood spontaneous SHOCK chance="+chance)
	if RandomFloat() < chance ; chance for spontaneous shock
		if RandomFloat() < (__chance_shock * amount)
			if mood == "shock"
				;LogTrace("choose mood spontaneous SCHOCK again")
				;LogTrace("choose mood spontaneous shock 0 = "+mood)
				return true ; no change
			endif
			mood = "shock"
			;LogTrace("choose mood spontaneous SHOCK "+mood)
			;LogTrace("choose mood spontaneous shock 1 = "+mood)
			return true
		endif
	endif
	; Is there a chance for happy
	chance = MOD_Forgiveness
	if is_slave && !is_freed_slave
		if actor_alias.is_trainer
			chance = chance*0.25
		else
			chance = chance*0.1
		endif
	endif
	;LogTrace("choose mood spontaneous HAPPY chance="+chance)
	if RandomFloat() < chance ; chance for being forgiving
		float x0 = __chance_charmed * amount
		float x3 = __chance_happy * amount
		if is_slave && !is_freed_slave
			if actor_alias.is_trainer
				x3 = x3*0.5
				x0 = x0*0.5
			else
				x3 = x3*0.2
				x0 = x0*0.2
			endif
		endif
		;LogTrace("choose mood spontaneous HAPPY chance="+x3)
		if RandomFloat() < x0
			;LogTrace("choose mood spontaneous CHARMED")
			if mood == "charmed"
				return true ; no change
			endif
			mood = "charmed"
			return true
		endif
		if RandomFloat() < x3
			;LogTrace("choose mood spontaneous HAPPY")
			if mood == "happy"
				return true ; no change
			endif
			mood = "happy"
			return true
		endif
		if RandomFloat() < x3*0.25
			;LogTrace("choose mood spontaneous FINE")
			if mood == "fine"
				return true ; no change
			endif
			mood = "fine"
			return true
		endif
	endif
	return false
EndFunction

Function ChooseMoodSpontaneous(float amount)
	;4 state of mind: neutral, active, passive, cooperative
	;LogTrace("ChooseMoodSpontaneous() canChangeMood="+canChangeMood)

	;### Cooperative moods
	if IsMoodSpontaneouslyCooperative(amount)
		return
	endif

	;### Next moods are choosen according to personality

	;### Passive moods first - Easier to manipulate = +E -XCO MOD_Manipulation
	if MOD_Manipulation > MOD_Rebellion && MOD_Manipulation > MOD_Impatience
		if IsMoodSpontaneouslyPassive(amount) ; 1xx
			;LogTrace("choose mood spontaneous passive 0 = "+mood)
			return
		endif
		if MOD_Impatience > MOD_Rebellion
			if IsMoodSpontaneouslyActive(amount) ; 12x
				;LogTrace("choose mood spontaneous active 0 = "+mood)
				return
			endif
			if IsMoodSpontaneouslyNeutral(amount) ; 123
				;LogTrace("choose mood spontaneous neutral 0 = "+mood)
				return
			endif
		endif
		if IsMoodSpontaneouslyNeutral(amount) ; 13x
			;LogTrace("choose mood spontaneous neutral 1 = "+mood)
			return
		endif
		IsMoodSpontaneouslyActive(amount) ; 132
		;LogTrace("choose mood spontaneous active 1 = "+mood)
		return
	endif

	;### Active moods first - Impulsive response to agression = +E-A MOD_Impatience
	if MOD_Impatience > MOD_Rebellion
		if IsMoodSpontaneouslyActive(amount) ; 2xx
			;LogTrace("choose mood spontaneous active 2 = "+mood)
			return
		endif
		if MOD_Manipulation > MOD_Rebellion
			if IsMoodSpontaneouslyPassive(amount) ; 21x
				;LogTrace("choose mood spontaneous passive 2 = "+mood)
				return
			endif
			if IsMoodSpontaneouslyNeutral(amount) ; 213
				;LogTrace("choose mood spontaneous neutral 2 = "+mood)
				return
			endif
		endif
		if IsMoodSpontaneouslyNeutral(amount) ; 23x
			;LogTrace("choose mood spontaneous neutral 3 = "+mood)
			return
		endif
		IsMoodSpontaneouslyPassive(amount) ; 231
		;LogTrace("choose mood spontaneous passive 3 = "+mood)
		return
	endif

	;### Neutral moods first - Resilience MOD_Rebellion
	if IsMoodSpontaneouslyNeutral(amount) ; 3xx
		;LogTrace("choose mood spontaneous neutral 4 = "+mood)
		return
	endif
	if MOD_Manipulation > MOD_Impatience
		if IsMoodSpontaneouslyPassive(amount) ; 31x
			;LogTrace("choose mood spontaneous passive 4 = "+mood)
			return
		endif
		IsMoodSpontaneouslyActive(amount) ; 312
		;LogTrace("choose mood spontaneous active 4 = "+mood)
		return
	endif
	if IsMoodSpontaneouslyActive(amount) ; 32x
		;LogTrace("choose mood spontaneous active 5 = "+mood)
		return
	endif
	if IsMoodSpontaneouslyPassive(amount) ; 321
		return
	endif
	;LogTrace("choose mood spontaneous passive 5 = "+mood)
EndFunction

Function ChooseMoodSpontaneousOnTick(float amount)
	if mood_swing_ticks <= mood_swing_max
		return
	endif
	ChooseMoodSpontaneous(amount)
	mood_swing_ticks = 0
EndFunction

; ### Event related mood change

Function MakeCry()
	; if threatened not to cry
	if WasWarned(4) ; "crying"
		; First try to swallow tears
		if RandomFloat() < MOD_Prudent*0.5
			actor_alias.TryApplyTears()
			SetNextPunishmentReasonSilent(4) ; "crying"
			SetNextPraiseReasonSilent(4) ; "crying"
			;LogTrace("Shed tears actorType="+actorType)
			if actorType == 0
				SendNotificationAbuse(name+" bursts into tears")
			else
				SendNotificationAbuse(name+" is really sad")
			endif
		else
			if actorType == 0
				SendNotificationAbuse(name+" swallows "+actorPossessive+" tears")
			else
				SendNotificationAbuse(name+" is trying hard not be sad")
			endif
		endif
	else
		actor_alias.TryApplyTears()
		SetNextPunishmentReasonSilent(4) ; "crying"
		SetNextPraiseReasonSilent(4) ; "crying"
	endif
EndFunction

bool Function MakeMoodAfraid(float amount)
	float chance1 = __chance_afraid
	float chance2 = __chance_terrified
	float chance3 = __chance_scared
	if chance1 > chance2 && chance1 > chance3
		if RandomFloat() < chance1 * amount
			mood = "afraid"
			return true
		endif
		return false
	elseif chance2 > chance3
		if RandomFloat() < chance2 * amount
			mood = "terrified"
			return true
		endif
		return false
	elseif RandomFloat() < chance3 * amount
		mood = "scared"
		return true
	endif
	return false
EndFunction

bool Function MakeMoodAngry(float amount)
	float chance1 = __chance_angry
	float chance2 = __chance_defiant
	if chance1 > chance2 
		if RandomFloat() < chance1 * amount
			mood = "angry"
			return true
		endif
		return false
	elseif RandomFloat() < chance2 * amount
		mood = "defiant"
		return true
	endif
	return false
EndFunction

bool Function MakeMoodSad(float amount)
	float chance1 = __chance_sad
	float chance2 = __chance_crushed
	if chance1 > chance2 
		if RandomFloat() < chance1 * amount
			mood = "sad"
			return true
		endif
		return false
	elseif RandomFloat() < chance2 * amount
		mood = "crushed"
		return true
	endif
	return false
EndFunction

bool Function MakeMoodAshamed(float amount)
	float chance1 = __chance_ashamed
	float chance2 = __chance_proud
	if chance1 > chance2 
		if RandomFloat() < chance1 * amount
			mood = "ashamed"
			return true
		endif
		return false
	elseif RandomFloat() < chance2 * amount
		mood = "proud"
		return true
	endif
	return false
EndFunction

bool Function MakeStopPose()
	if IsObedient()
		return false
	endif
	Float base_chance
	if __drunk_level >= 3
		base_chance = (1.0-( pose_training / 100.0 ))
	else
		base_chance = StopOrderMoodBase(pose_training)
		if base_chance == 0.0 ; Will not stop
			;LogTrace("MakeStopPose: Stop pose chance="+base_chance)
			return false
		endif
	endif
	if actor_alias.has_leash || actor_alias.is_leashed
		base_chance *= 0.2
	endif
	if actor_alias.has_collar || actor_alias.has_device
		base_chance *= 0.5
	endif
	Float sub_chance =  ChanceRangeLow(humiliation)
	Float chance = base_chance * sub_chance * __chance_recently_punished_inverted
	chance += __drunk_level*0.1
	;LogTrace("MakeStopPose: chance="+chance+" base="+base_chance+" recently punished="+__chance_recently_punished_inverted+" sub="+sub_chance)
	bool was_warned = WasWarned(15) ; "didnt pose"
	if was_warned
		chance *= (1.0-MOD_Fearfulness*0.5)
	endif

	;LogTrace("MakeStopPose chance="+base_chance+" sub "+sub_chance+" = "+chance)
	float x = RandomFloat()
	if x < chance
		if was_warned
			chance = chance * (1.0-MOD_Fearfulness)
			;LogTrace("MakeStopPose warned stop pose chance="+chance)
			if x < chance
				MakeAngryFor(2.0)
				return true
			else
				MakeAfraidFor(2.0)
				SendNotificationAbuse(name+" keeps posing, scared of being punished")
				return false
			endif
		else
			MakeAngryFor(5.0)
			return true
		endif
	endif
	return false
EndFunction

bool Function MakeStopMasturbate()
	if IsObedient()
		return false
	endif
	Float base_chance
	if __drunk_level >= 3
		base_chance = (1.0-( pose_training / 100.0 ))
	else
		base_chance = StopOrderMoodBase(vaginal_training)*(1.0-( humiliation / 100.0 ))
		if base_chance == 0
			;LogTrace("MakeStopMasturbate chance="+base_chance)
			return false
		endif
	endif
	if actor_alias.has_leash || actor_alias.is_leashed
		base_chance *= 0.2
	endif
	if actor_alias.has_collar || actor_alias.has_device
		base_chance *= 0.5
	endif
	Float sub_chance =  ChanceRangeLow(submission)
	Float chance = base_chance * sub_chance * __chance_recently_punished_inverted
	chance += __drunk_level*0.1
	bool was_warned = WasWarned(19) ; "didnt masturbate"
	if was_warned
		chance *= (1.0-MOD_Fearfulness*0.5)
	endif

	;LogTrace("MakeStopMasturbate chance base "+base_chance+" sub "+sub_chance+" = "+chance+" drunk level = "+__drunk_level)

	float x = RandomFloat()
	if x < chance
	if was_warned
		chance *= (1.0-MOD_Fearfulness*0.5)
		;LogTrace("MakeStopMasturbate warned stop masturbate chance="+chance)
			if x < chance
				MakeAngryFor(2.0)
				return true
			else
				SendNotificationAbuse(name+" masturbates, scared of being punished")
				MakeAfraidFor(2.0)
				return false
			endif
		else
			MakeAngryFor(5.0)
			return true
		endif
	endif
	return false
EndFunction

bool Function MakeStopWait()
	if timer_obedient > 0
		;LogTrace("MakeStopWait chance=0 decided to obey")
		return false
	endif
	Float base_chance = StopWaitingMoodBase()
	if base_chance == 0.0
		;LogTrace("MakeStopWait chance="+base_chance+" mood forced obedience")
		return false
	endif
	if actor_alias.has_cuffs_back || actor_alias.has_cuffs_boxtied
		base_chance *= 0.1
	elseif actor_alias.has_cuffs_front || actor_alias.has_cuffs_crossed
		base_chance *= 0.3
	endif
	if actor_alias.has_leash || actor_alias.is_leashed
		base_chance *= 0.2
	endif
	if actor_alias.has_collar || actor_alias.has_device
		base_chance *= 0.5
	endif
	float res_chance = ChanceRangeLow(resignation)
	float psh_chance = __chance_recently_punished_inverted
	float chance = base_chance * res_chance * psh_chance

	float x = RandomFloat()
	;LogTrace("MakeStopWait x = "+x+" chance="+chance+" "+StopWaitingMoodBase()+" "+base_chance+" "+res_chance+" "+psh_chance)
	if x < chance
		MakeAngryFor(2.0)
		return true
	endif
	return false
EndFunction

bool Function MakeStopWork()
	if timer_obedient > 0
		;LogTrace("MakeStopWork chance=0 decided to obey")
		return false
	endif
	Float base_chance = StopOrderMoodBase(work_training)
	if base_chance == 0.0
		;LogTrace("MakeStopWork chance="+base_chance+" mood forced obedience")
		return false
	endif
	if actor_alias.has_leash || actor_alias.is_leashed
		base_chance *= 0.2
	endif
	if actor_alias.has_collar || actor_alias.has_device
		base_chance *= 0.5
	endif
	float res_chance = ChanceRangeLow(resignation)
	float psh_chance = __chance_recently_punished_inverted
	float chance = base_chance * res_chance * psh_chance

	float x = RandomFloat()
	;LogTrace("MakeStopWork x = "+x+" chance="+chance+" "+StopWaitingMoodBase()+" "+base_chance+" "+res_chance+" "+psh_chance)
	if x < chance
		MakeAngryFor(2.0)
		return true
	endif
	return false
EndFunction

bool Function MakeBreakTieup()
	if timer_obedient > 0
		;LogTrace("MakeBreakTieup chance=0 decided to obey")
		return false
	endif
	Float base_chance = StopOrderMoodBase(submission)
	if base_chance == 0.0
		;LogTrace("MakeBreakTieup chance="+base_chance+" mood forced obedience")
		return false
	endif
	if actor_alias.has_leash || actor_alias.is_leashed
		base_chance *= 0.2
	endif
	if actor_alias.has_collar || actor_alias.has_device
		base_chance *= 0.5
	endif
	float res_chance = ChanceRangeLow(resignation)
	float psh_chance = __chance_recently_punished_inverted
	float chance = base_chance * res_chance * psh_chance

	float x = RandomFloat()
	;LogTrace("MakeBreakTieup x = "+x+" chance="+chance+" "+StopWaitingMoodBase()+" "+base_chance+" "+res_chance+" "+psh_chance)
	if x < chance
		MakeAngryFor(2.0)
		return true
	endif
	return false
EndFunction

bool Function MakeBreakRestraint(float restraintModifier)
	if timer_obedient > 0
		;LogTrace("MakeBreakRestraint chance=0 decided to obey")
		return false
	endif
	Float baseValue = BreakRestraintMoodBase()
	;if baseValue == 0 ; To be checked by calling routine
	;	LogTrace("Break restraint chance="+baseValue)
	;	return false
	;endif
	Float chance = (baseValue * (__chance_recently_punished_inverted + RandomFloat() - 0.5))
	float smartModifier = (0.5+(100.0-FACET_Smartness)/100.0)*restraintModifier
	;LogTrace("smartModifier = "+smartModifier+" break restraint chance = "+chance)
    ;LogTrace("MakeBreakRestraint chance=" + chance)
	if chance > smartModifier
		;LogTrace("MakeBreakRestraint 368 CanBreakRestraints=true")
		MakeAngryFor(10.0)
		return true
	endif
	;LogTrace("MakeBreakRestraint CanBreakRestraints=false")
	return false
EndFunction

bool Function MakeRunAway()
	if timer_obedient > 0
		;LogTrace("MakeRunAway chance=0 decided to obey")
		return false
	endif
	if __chance_runaway == 0.0
		;LogTrace("MakeRunAway runaway forbidden")
		return false
	endif
	Float chance = __chance_runaway * DOM01.chanceRunAwayMultiplier ; ChanceRunAway()
	;LogTrace("MakeRunAway runaway chance="+chance+" canRunAway="+actor_alias.canRunAway+" has_leash="+actor_alias.has_leash)
	if RandomFloat() < chance
		if actor_alias.canRunAway
			if actor_alias.has_leash || actor_alias.is_leashed
				SetNextPunishmentReasonForceMessage(25,"'s escape wish vanishes as "+actorPossessive+" restraints tighten") ; "running_away"
				TrainSubmission(5.0)
				TrainResignation(5.0)
				;LogTrace("MakeRunAway no chance slave is leashed")
				return false
			endif
			;LogTrace("MakeRunAway yes chance="+chance+" has_leash="+actor_alias.has_leash)
			return actor_alias.TryRunAway()
		else
			;LogTrace("MakeRunAway - can not -> calls for help")
			actor_alias.TryCallForHelp()
			return false
		endif
	endif
	;LogTrace("MakeRunAway no chance="+chance)
	return false
EndFunction

bool Function MakeRunAwayGang(float xfriendship)
	if __chance_runaway_gang == 0.0
		;LogTrace("MakeRunAwayGang runaway forbidden")
		return false
	endif
	Float chance = __chance_runaway_gang * (xfriendship+1.0) * DOM01.chanceRunAwayMultiplier ; ChanceRunAwayGang()
	if RandomFloat() < chance
		if actor_alias.canRunAway
			if actor_alias.has_leash || actor_alias.is_leashed
				SetNextPunishmentReasonForceMessage(25,"'s escape wish vanishes as "+actorPossessive+" restraints tighten") ; "running_away"
				TrainSubmission(5.0)
				TrainResignation(5.0)
				;LogTrace("MakeRunAwayGang no chance slave is leashed")
				return false
			endif
			;LogTrace("MakeRunAwayGang runaway")
			return actor_alias.TryRunAwayGang() ; This is needed to avoid endless loop in friends
		else
			;LogTrace("MakeRunAwayGang can not gang runaway - calls for help")
			actor_alias.TryCallForHelp()
			return false
		endif
	endif
	return false
EndFunction

bool Function MakeAngryForFriend(Float base_amount)
	if IsDevoted()
		return false
	elseif actor_alias.is_running_away
		IncreaseAngerForFriend(base_amount)
		if !IsAngry()
			if MakeAngryForInjustice()
				return true
			endif
			return false
		endif
		return true
	elseif IsBrokenToObey()
		if RandomFloat() < MOD_Discipline
			SendNotificationAbuse(name+" remembers your warning and tries to control "+actorPossessive+" rage")
			TrainAnger(base_amount)
		endif
		return false
	elseif __warn_punishment_reason == 12 ; "being angry"
		if RandomFloat() < MOD_Discipline
			SendNotificationAbuse(name+" remembers your warning and tries to control "+actorPossessive+" rage")
			TrainAnger(base_amount)
			return false
		elseif RandomFloat()*0.75 < MOD_Forgiveness
			SetNextPunishmentReasonSilent(12) ; "being angry"
		else
			return false
		endif
	elseif RandomFloat()*0.75 < MOD_Forgiveness
		SetNextPunishmentReasonSilent(12) ; "being angry"
	endif

	IncreaseAngerForFriend(base_amount)
	if !IsAngry()
		if MakeAngryForInjustice()
			return true
		endif
		return false
	endif
	return true
EndFunction

Function MakeFlatteredForGreed(Float base_amount)
	if promiseOath == "money"
		promise_kept += base_amount as int
		base_amount *= 2.0
	endif
	if !DOM01.greedToggle
		return
	endif
	if (!IsBrokenToObey() || !IsDevoted())
		if MOD_Greed < 0.34
			base_amount *= 0.5
		else
			return
		endif
	endif
	if IsInLove()
		base_amount *= 2.0
	endif
	TrainForGreed(base_amount)
	SendNotificationAbuse(name+"'s eyes light up as "+actorPronoun+" looks at "+actorPossessive+" new jewelry")
	if IsAngry()
		RecoverFrom()
	elseif IsSad()
		RecoverFrom()
	endif
EndFunction

Function MakeAngryForTaken(Float base_amount)
	if promiseOath == "money"
		promise_kept -= base_amount as int
		base_amount *= 2.0
	endif
	if !DOM01.greedToggle
		return
	endif
	if actor_alias.is_running_away
		IncreaseAngerForGreed(base_amount)
		if !IsAngry()
			MakeAngryForGreed()
		endif
		return
	elseif __warn_punishment_reason == 12 ; "being angry"
		if RandomFloat() < MOD_Discipline
			SendNotificationAbuse(name+" remembers your warning and tries to control "+actorPossessive+" rage")
			base_amount = base_amount*0.1
		else
			SetNextPunishmentReasonSilent(12) ; "being angry"
		endif
	else
		SetNextPunishmentReasonSilent(12) ; "being angry"
	endif
	IncreaseAngerForGreed(base_amount)
	SendNotificationAbuse(name+" looks upset about what you took from "+actorObjective)
	if !IsAngry()
		MakeAngryForGreed()
	endif
EndFunction

bool Function MakeAngryForGreed()
	if !DOM01.greedToggle
		return false
	endif
	Float chance = ChanceAngryForGreed() ; no caching because used only on inventory open
	;LogTrace("set angry greed="+chance)
	if RandomFloat() < chance
		if __chance_angry > __chance_defiant
			mood = "angry"
		else
			mood = "defiant"
		endif
		return true
	endif
	return false
EndFunction

bool Function MakeAngryForUnfairness()
	Float chance = __chance_angry_for_unfairness
	;LogTrace("set angry for unfairness="+chance)
	if RandomFloat() < chance
		if __chance_angry > __chance_defiant
			mood = "angry"
		else
			mood = "defiant"
		endif
		return true
	endif
	return false
EndFunction

bool Function MakeAngryForInjustice()
	Float chance = __chance_angry_for_injustice
	;LogTrace("set angry for injustice="+chance)
	if RandomFloat() < chance
		if __chance_angry > __chance_defiant
			mood = "angry"
		else
			mood = "defiant"
		endif
		return true
	endif
	return false
EndFunction

Function MakeAngryFor(Float base_amount)
	if IsDevoted()
		if anger_training < 100.0
			if is_slave
				SendNotificationAbuse(name+" wants to be a good slave and tries to control "+actorPossessive+" rage")
			else
				SendNotificationAbuse(name+" wants to be the perfect slaver and tries to control "+actorPossessive+" rage")
			endif
			TrainAnger(base_amount)
		endif
		return
	elseif actor_alias.is_running_away
		IncreaseAnger(base_amount)
		if !IsAngry()
			MakeAngryForUnfairness() ; chance to change mood to angry
		endif
		return
	elseif IsBrokenToObey()
		if RandomFloat() < MOD_Discipline
			if is_slave
				SendNotificationAbuse(name+" tries hard to be a good slave and control "+actorPossessive+" rage")
			else
				SendNotificationAbuse(name+" tries hard to be the perfect slaver and control "+actorPossessive+" rage")
			endif
			TrainAnger(base_amount)
		endif
		return
	elseif __warn_punishment_reason == 12 ; "being angry"
		if RandomFloat() < MOD_Discipline
			SendNotificationAbuse(name+" remembers your warning and tries to control "+actorPossessive+" rage")
			TrainAnger(base_amount)
			return
		elseif RandomFloat()*0.75 < MOD_Forgiveness
			SetNextPunishmentReasonSilent(12) ; "being angry"
		else
			return
		endif
	elseif RandomFloat()*0.75 < MOD_Forgiveness
		SetNextPunishmentReasonSilent(12) ; "being angry"
	endif

	IncreaseAnger(base_amount)
	if !IsAngry()
		MakeAngryForUnfairness() ; chance to change mood to angry
	endif
EndFunction

Function MakeAshamedFor(Float base_amount)
	if mood != "ashamed" && !IsBrokenToObey() && !IsObedient()
		MakeAshamed()
	endif
	
	if mood == "ashamed"
		if actor_alias.is_in_city
			base_amount *= 2.0
			SendNotificationAbuse(name+" feels ashamed being in a public place")
		endif
	endif

	number_of_shame += 1
	;PrintTrainingBefore("mood",base_amount,"ashamed")
	TrainHumiliation(base_amount)
	;PrintTrainingAfter("mood",base_amount,"ashamed")

	if actor_alias.canIdle
		TryCoverSelf()
	endif
EndFunction

bool Function MakeAshamed()
	Float chance = __chance_ashamed_spontaneous
	;LogTrace("ashamed chance="+base_chance+" * "+mod_chance+" = "+chance)
	;LogTrace("ashamed chance="+chance)
	if RandomFloat() < chance
		if __chance_ashamed > __chance_proud
			mood = "ashamed"
			return true
		endif
		mood = "proud"
	endif
	return false
EndFunction

bool Function MakeSadForFriend(Float base_amount)
	if IsDevoted()
		SendNotificationAbuse(name+" remembers your warning and cools down")
		base_amount = base_amount*0.1
	endif
	TrainResignation(MOD_Empathy*base_amount)
	if !IsSad()
		if MakeSadForInjustice()
			return true
		endif
		return false
	endif
	return true
EndFunction

bool Function MakeSadForUnfairness()
	Float chance = __chance_sad_for_unfairness
	;LogTrace("set sad unfairness chance="+chance)
	if RandomFloat() < chance
		if __chance_sad > __chance_crushed 
			mood = "sad"
			return true
		endif
		mood = "crushed"
		return true
	endif
	return false
EndFunction

bool Function MakeSadForInjustice()
	if mood == "shock"
		;LogTrace("sad chance=0 mood is shock")
		return false
	endif
	Float chance = __chance_sad_for_injustice 
	;LogTrace("set sad injustice="+chance)
	if RandomFloat() < chance
		if __chance_sad > __chance_crushed 
			mood = "sad"
			return true
		endif
		mood = "crushed"
		return true
	endif
	return false
EndFunction

Function MakeSadFor(Float base_amount)
	if !IsSad() && !IsBrokenToObey()
		MakeSadForUnfairness()
	endif
	
	if IsSad()
		if actor_alias.is_in_dungeon
			base_amount *= 1.5
			SendNotificationAbuse(name+" is downhearted being in such a sinister place")
		endif
	endif
	
	TrainResignation(base_amount)
EndFunction

Function MakeAfraidFor(Float base_amount)
	if !isAfraid() && !IsBrokenToObey()
		MakeAfraid()
	endif

	if IsAfraid()
		if actor_alias.is_in_dungeon
			base_amount *= 1.5
			SendNotificationAbuse(name+" is horrified being in such a chilling place")
		endif
	endif

	TrainFear(base_amount)
EndFunction

bool Function MakeAfraid()
	if mood == "shock"
		;LogTrace("afraid chance=0 mood is shock")
		return false
	endif
	Float base_chance = __chance_afraid_spontaneous
	;LogTrace("set afraid/terrified/scared base chance="+base_chance)
	return MakeMoodAfraid(base_chance)
EndFunction

float Function GetPersonalityCheck(DOM_Mind akOther)
	; Personality check between two NPC to see if they match as friends (no physical traits)
	float x
	x = 100.0-math.abs(HEXACO_Honesty-akOther.HEXACO_Honesty) ; same attract
	x = x+math.abs(HEXACO_Emotionality-akOther.HEXACO_Emotionality) ; diff attract
	x = x+math.abs(HEXACO_eXtraversion-akOther.HEXACO_eXtraversion) ; diff attract
	x = x+HEXACO_Agreeableness+akOther.HEXACO_Agreeableness ; kindness as bonus
	x = x+50.0-math.abs(math.abs(50.0-HEXACO_Conscientiousness)-math.abs(50.0-akOther.HEXACO_Conscientiousness))  ; opposite attracts
	x = x+100.0-math.abs(HEXACO_Openness-akOther.HEXACO_Openness) ; same attract
	x = x/600.0
	
	; Extra checks have less impact
	float y
	y = math.abs(FACET_Boldness-akOther.FACET_Boldness) ; diff attract 
	; Weak/Wilful, no effect
	y = y+100.0-math.abs(FACET_Smartness-akOther.FACET_Smartness) ; same attract
	; Frigid/Sensual, no effect
	; Delicate/Tough, no effect
	; Dominant/Submissive, no effect
	y = y/200.0

	;LogTrace("Friend compatibility between "+name+" and "+akOther.name+" = "+x+" +0.1* "+y+" = "+(x+0.1*y))
	return x+y*0.1
EndFunction

; ### Mood chance Functions ###

float __chance_runaway = 0.0
Function SetChanceRunAway()
	__chance_runaway = ChanceRunAway()
EndFunction
float Function GetChanceRunAway()
	__chance_runaway = ChanceRunAway()
	return __chance_runaway
EndFunction
float Function ChanceRunAway()
	;if !actor_alias.canMove
	;	;LogTrace("Runaway chance=0 can not move")
	;	return 0.0
	;endif
	if !is_slave || is_player_actor
		;LogTrace("Runaway chance=0 not a slave or player")
		return 0.0
	endif
	if !is_player_slave
		;LogTrace("Runaway chance=0 not a player's slave")
		return 0.0
	endif
	Float base_chance = RunAwayMoodBase()
	if base_chance == 0.0
		;LogTrace("Runaway chance=0 because of mood")
		return 0.0
	endif
	;LogTrace("Runaway base chance="+base_chance)
	if __drunk_level > 3 || IsPassedout()
		;LogTrace("Runaway chance=0 Drunk or Passed out Runaway")
		return 0.0
	endif
	; Drunk people won't often decide to runaway by themselves
	if __drunk_level > 0
		base_chance = base_chance * (1.0-(0.2*(__drunk_level as float)))
		;LogTrace("Runaway drunk corrected="+base_chance)
	endif
	if actor_alias.has_blindfold
		base_chance = base_chance*0.33
	elseif actor_alias.has_device || actor_alias.has_cuffs_back || actor_alias.has_cuffs_boxtied
		base_chance = base_chance*0.66
	elseif actor_alias.has_collar || actor_alias.has_cuffs_front || actor_alias.has_cuffs_crossed
		base_chance = base_chance*0.84
	endif
	if actor_alias.has_weapon > 0.0
		base_chance = base_chance*(1.0+0.02*actor_alias.has_weapon)
	elseif actor_alias.has_weapon_in_inventory
		base_chance = base_chance*1.04
	endif
	if actor_alias.has_armor > 0.0
		base_chance = base_chance*(1.0+0.02*actor_alias.has_armor)
	elseif actor_alias.has_armor_in_inventory || actor_alias.has_shield_in_inventory
		base_chance = base_chance*1.04
	endif
	if number_of_capturedslaves > 0
		int nc = number_of_capturedslaves
		base_chance = base_chance/(1+nc/32.0)
	endif
	
	;base_chance = base_chance*0.5
	Float sub_chance = ChanceRangeLow(resignation,0.0, DOM01.runAwayValue)
	Float rec_chance = __chance_recently_punished_inverted
	Float chance = base_chance * sub_chance * rec_chance
	if WasWarned(25) ; "running away"
		chance *= (1.0-MOD_Fearfulness*0.5)
		;LogTrace("Runaway was warned chance="+chance)
	endif
	;LogTrace("Runaway chance="+chance+" base "+base_chance+" resignation "+sub_chance+" recently "+rec_chance)
	;LogTrace("Runaway chance="+chance)
	return chance
EndFunction

float __chance_runaway_gang = 0.0
Function SetChanceRunAwayGang()
	__chance_runaway_gang = ChanceRunAwayGang()
EndFunction
float Function GetChanceRunAwayGang()
	__chance_runaway_gang = ChanceRunAwayGang()
	return __chance_runaway_gang
EndFunction
float Function ChanceRunAwayGang()
	if !is_slave || is_player_actor
		;LogTrace("Runawaygang chance=0 not a slave or player")
		return 0.0
	endif
	if !is_player_slave
		;LogTrace("Runawaygang chance=0 not a player's slave")
		return 0.0
	endif
	if !actor_alias.canMove
		;LogTrace("Runawaygang chance=0 can not move")
		return 0.0
	endif
	Float base_chance = RunAwayMoodBase()
	if base_chance == 0.0
		;LogTrace("Runawaygang chance=0 because of mood")
		return 0.0
	endif
	if __drunk_level > 3 || IsPassedout()
		;LogTrace("Runawaygang chance=0 Drunk or Passed out Runaway")
		return 0.0
	endif
	; Drunk people might stupidly follow their friends
	if __drunk_level > 0
		base_chance = 0.1+base_chance / (1.0-(0.2*(__drunk_level as float)))
	endif
	if actor_alias.has_blindfold
		base_chance = base_chance*0.50
	elseif actor_alias.has_device || actor_alias.has_cuffs_back || actor_alias.has_cuffs_boxtied
		base_chance = base_chance*0.84
	elseif actor_alias.has_collar || actor_alias.has_cuffs_front || actor_alias.has_cuffs_crossed
		base_chance = base_chance*0.92
	endif
	if actor_alias.has_weapon > 0.0
		base_chance = base_chance*(1.0+0.04*actor_alias.has_weapon)
	elseif actor_alias.has_weapon_in_inventory
		base_chance = base_chance*1.04
	endif
	if actor_alias.has_armor > 0.0
		base_chance = base_chance*(1.0+0.04*actor_alias.has_armor)
	elseif actor_alias.has_armor_in_inventory || actor_alias.has_shield_in_inventory
		base_chance = base_chance*1.04
	endif
	
	Float sub_chance = (base_chance * ChanceRangeLow(resignation, 0.0, DOM01.runAwayValue))
	Float recent_chance = (sub_chance * __chance_recently_punished_inverted)
	; Basic chance is increased by a factor X as friend is already running away
	Float chance = recent_chance
	if WasWarned(25) ; "running_away"
		chance *= (1.0-MOD_Fearfulness*0.5)
	endif

	;LogTrace("Gang Runaway chance "+name+": base "+base_chance+" sub "+sub_chance+" recent "+recent_chance+" friend "+chance)
	;LogTrace("Gang runaway chance="+chance)
	return chance
EndFunction

float Function ChanceCallForHelp()
	if !is_slave
		;LogTrace("Call for help chance=0 not a slave")
		return 0.0
	endif
	if !is_player_slave
		;LogTrace("Call for help chance=0 not a palyeer's slave")
		return 0.0
	endif
	Float base_chance = CallForHelpMoodBase()
	if base_chance == 0.0
		;LogTrace("Call for help chance=0 because of mood")
		return 0.0
	endif
	if __drunk_level > 3 || IsPassedout()
		;LogTrace("CallForHelp chance=0 Drunk or Passed out")
		return 0.0
	endif
	if __drunk_level > 0
		base_chance = base_chance * (1.0-(0.2*(__drunk_level as float)))
	endif
	base_chance = base_chance * (0.1+0.2*(5.0-MOD_Naivety))
	if !actor_alias.is_bounded
		if actor_alias.has_weapon > 0.0
			base_chance = base_chance*(1.0+0.02*actor_alias.has_weapon)
		elseif actor_alias.has_weapon_in_inventory
			base_chance = base_chance*1.02
		endif
	endif
	if actor_alias.is_naked
		base_chance = base_chance*0.75
	endif
	if actor_alias.has_armor > 0.0
		base_chance = base_chance*(1.0+0.02*actor_alias.has_armor)
	elseif actor_alias.has_armor_in_inventory || actor_alias.has_shield_in_inventory
		base_chance = base_chance*1.02
	endif
	if actor_alias.is_in_city
		base_chance += 0.25
	endif
	;LogTrace("Call for help chance="+base_chance)
	return base_chance
EndFunction

Float Function ChanceAngryForGreed()
	; -=TAK=- Make use of personnality traits in formula
	Float base_chance = MOD_Criminality
	if base_chance < 0.34
		;LogTrace("Angry for greed=0 resistant to impatience")
		return 0
	elseif base_chance > 0.66 ; Sensitive to anger
		base_chance = base_chance*1.2
	endif
	if actor_alias.has_weapon > 0.0
		base_chance = base_chance*(1.0+0.01*actor_alias.has_weapon)
	elseif actor_alias.has_weapon_in_inventory
		base_chance = base_chance*1.01
	endif
	Float modifier = MOD_Greed*ChanceRangeLow(submission,50.0, 100.0)/5.0
	Float chance = base_chance * modifier * (1.0 - (anger_training / 100.0))
	;LogTrace("Angry greed chance "+name+" "+chance+" anger modifier = "+base_chance+" anger training = "+anger_training)
	;LogTrace("Angry for greed="+chance)
	return chance
EndFunction

Float Function ChanceDecayOverTime(Float time, Float half_life = 60.0, Float max_val = 1.0, Float min_val = 0.0)
	return ((max_val - min_val) / ((time/half_life) + 1)) + min_val
EndFunction

Float Function ChanceRangeHigh(Float stat, Float stat_min = 0.0, Float stat_max = 100.0)
	Float chance_multiplier = (stat-stat_min)/(stat_max-stat_min)
	if chance_multiplier > 1.0
		chance_multiplier = 1.0
	elseif chance_multiplier < 0.0
		chance_multiplier = 0.0
	endif
	;LogTrace("ChanceRangeHigh() "+chance_multiplier)
	return chance_multiplier
EndFunction

Float Function ChanceRangeLow(Float stat, Float stat_min = 0.0, Float stat_max = 100.0)
	Float chance_multiplier = (stat_max-stat)/(stat_max-stat_min)
	if chance_multiplier > 1.0
		chance_multiplier = 1.0
	elseif chance_multiplier < 0.0
		chance_multiplier = 0.0
	endif
	;LogTrace("ChanceRangeLow() "+chance_multiplier)
	return chance_multiplier
EndFunction

; ### Mood chance values ###

Float __chance_happy = 0.0
Function SetChanceHappy()
	__chance_happy = ChanceHappy()
EndFunction
float Function GetChanceHappy()
	__chance_happy = ChanceHappy()
	return __chance_happy
EndFunction
Float Function ChanceHappy()
	; -=TAK=- Make use of personnality traits in formula
	if is_slave && !__is_freed_slave
		;LogTrace("Happy chance=0 not a free person")
		return 0.0
	endif
	Float base_chance = MOD_SelfEsteem
	if actor_alias.has_weapon > 0.0
		base_chance = base_chance+0.02*actor_alias.has_weapon
	elseif actor_alias.has_weapon_in_inventory
		base_chance = base_chance+0.02
	endif
	if actor_alias.is_bounded
		base_chance = base_chance*0.34
	endif
	if is_freed_slave
		base_chance = base_chance*1.5
	endif
	
	int rank = akRef.GetRelationshipRank(PlayerRef)
	float chance_rel = 1.0+(rank as float)*0.05

	; Number of times 
	float nf = number_of_flatter*MOD_Hope/10.0
	float np = number_of_praise*MOD_Manipulation/15.0
	float ny = (number_of_chat_feelings+number_of_chat_personality)*MOD_Empathy/20.0
	float ns = number_of_trainee*(MOD_Intimidate-(0.66))
	float nt = number_of_trainer*(MOD_Criminality-(0.66))
	float nc = (number_of_capturedslaves+number_of_whoredslaves)*(MOD_Resentment-(0.66))
	float na = (number_of_soldslaves+number_of_ransomedslaves)*(MOD_Controller-(0.66))
	float nb = number_of_brokenslaves*(MOD_Insensitivity-(0.66))
	float no = number_of_orgasm*MOD_Orgasm/3.0
	
	if ns < 0.0
		ns = 0.0
	endif
	if nt < 0.0
		nt = 0.0
	endif
	if nc < 0.0
		nc = 0.0
	endif
	if na < 0.0
		na = 0.0
	endif
	if nb < 0.0
		nb = 0.0
	endif
	
	float modevents1 = (np+ny+nf+no)
	float modevents2 = (ns+nt+nc+na+nb)
	Float chance = base_chance * chance_rel * ((modevents1+anger_training/200.0) + (modevents2+skill_predator/200.0)) ; happy because of relation to player or because of job
	if actor_alias.has_jewelry > 0.0 && chance > 0.34
		chance = chance*(1.0+0.01*actor_alias.has_jewelry*MOD_Greed)
	endif
	if actor_alias.has_gold > 0.0 && chance > 0.50
		chance = chance*(1.0+0.0002*actor_alias.has_gold*MOD_Greed) ; 0.01/50.0
	endif
	;LogTrace("Happy chance="+chance+" ns="+ns+" nt="+nt+" events="+modevents+" base="+base_chance)
	;LogTrace("Happy chance="+chance)
	return chance
EndFunction

Float __chance_angry = 0.0
Function SetChanceAngry()
	__chance_angry = ChanceAngry()
EndFunction
float Function GetChanceAngry()
	__chance_angry = ChanceAngry()
	return __chance_angry
EndFunction
Float Function ChanceAngry()
	; -=TAK=- Make use of personnality traits in formula
	Float base_chance = MOD_Impatience
	if base_chance < 0.34
		;LogTrace("Angry chance=0 resistant to impatience")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to anger
		base_chance = base_chance*1.2
	endif
	if actor_alias.has_weapon > 0.0
		base_chance = base_chance+0.02*actor_alias.has_weapon
	elseif actor_alias.has_weapon_in_inventory
		base_chance = base_chance+0.02
	endif
	if actor_alias.is_bounded || is_freed_slave
		base_chance = base_chance*0.66
	endif
	Float chance = base_chance * (1.0 - (anger_training / 100.0))
	;LogTrace("Angry chance "+name+" "+chance+" anger modifier = "+base_chance+" anger training = "+anger_training)
	;LogTrace("Angry chance="+chance)
	return chance
EndFunction

Float __chance_angry_for_unfairness = 0.0
Function SetChanceAngryForUnfairness()
	__chance_angry_for_unfairness = ChanceAngryForUnfairness()
EndFunction
Float Function ChanceAngryForUnfairness()
	; -=TAK=- Jealousy anger
	Float base_chance = MOD_Dependence
	if base_chance < 0.34
		;LogTrace("Angry for unfairness=0 resistant to dependence")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to anger
		base_chance = base_chance*1.2
	endif
	if actor_alias.has_weapon > 0.0
		base_chance = base_chance*(1.0+0.02*actor_alias.has_weapon)
	elseif actor_alias.has_weapon_in_inventory
		base_chance = base_chance*1.02
	endif
	Float modifier = MOD_Resentment*ChanceRangeLow(resignation,50.0, 100.0)
	Float chance = base_chance * modifier * (1.0 - (anger_training / 100.0))
	;LogTrace("Angry for unfairness chance "+name+" "+chance+" anger modifier = "+base_chance+" anger training = "+anger_training)
	;LogTrace("Angry for unfairness="+chance)
	return chance
EndFunction

Float __chance_angry_for_injustice = 0.0
Function SetChanceAngryForInjustice()
	__chance_angry_for_injustice = ChanceAngryForInjustice()
EndFunction
Float Function ChanceAngryForInjustice()
	; -=TAK=- Empathetic anger
	Float base_chance = MOD_Empathy
	if base_chance < 0.34 
		;LogTrace("Angry for injustice=0 resistant to empathy")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to anger
		base_chance = base_chance*1.2
	endif
	if actor_alias.has_weapon > 0.0
		base_chance = base_chance*(1.0+0.02*actor_alias.has_weapon)
	elseif actor_alias.has_weapon_in_inventory
		base_chance = base_chance*1.02
	endif
	Float modifier = MOD_Rebellion*ChanceRangeLow(resignation,50.0, 100.0)
	Float chance = base_chance * modifier * (1.0 - (anger_training / 100.0))
	;LogTrace("Angry for injustice chance "+name+" "+chance+" anger modifier = "+base_chance+" anger training = "+anger_training)
	;LogTrace("Angry for injustice="+chance)
	return chance
EndFunction

Float __chance_defiant = 0.0
Function SetChanceDefiant()
	__chance_defiant = ChanceDefiant()
EndFunction
float Function GetChanceDefiant()
	__chance_defiant = ChanceDefiant()
	return __chance_defiant
EndFunction
Float Function ChanceDefiant()
	; -=TAK=- Make use of personnality traits in formula
	; defiant = anger
	Float base_chance = MOD_Rebellion
	if base_chance < 0.34 ; Resistant to anger
		;LogTrace("Defiant chance=0 resistant to rebellion")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to anger
		base_chance = base_chance*1.2
	endif
	if actor_alias.has_weapon > 0.0
		base_chance = base_chance+0.02*actor_alias.has_weapon
	elseif actor_alias.has_weapon_in_inventory
		base_chance = base_chance+0.02
	endif
	if actor_alias.is_bounded || is_freed_slave
		base_chance = base_chance*0.66
	endif

	Float chance = base_chance * (0.2+anger_training / 80.0) * (1.0-respect_training / 120.0)
	;LogTrace("Defiant chance "+name+" "+chance+" anger modifier = "+base_chance+" anger training = "+anger_training)
	;LogTrace("Defiant chance="+chance)
	return chance
EndFunction

Float __chance_afraid = 0.0
Function SetChanceAfraid()
	__chance_afraid = ChanceAfraid()
	SetChanceAfraidSpontaneous()
EndFunction
float Function GetChanceAfraid()
	__chance_afraid = ChanceAfraid()
	return __chance_afraid
EndFunction
Float Function ChanceAfraid()
	; -=TAK=- Make use of personnality traits in formula
	; afraid = fear - sorrow
	Float base_chance = MOD_Fearfulness
	if MOD_Prudent > 0.5
		base_chance -= MOD_Prudent-(0.5)
	else
		base_chance += 0.5-MOD_Prudent
	endif
	if base_chance < 0.34 ; Resistant to fear of danger
		;LogTrace("Afraid chance=0 resistant to fear or easily terrified")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to fear
		;LogTrace("Afraid chance="+base_chance+" +20% sensitive to fear")
		base_chance = base_chance*1.2
	endif
	;LogTrace("Afraid chance="+base_chance+" is new base")
	if actor_alias.has_armor > 0.0
		base_chance = base_chance*(1.0-(0.01*actor_alias.has_armor))
	elseif actor_alias.has_armor_in_inventory || actor_alias.has_shield_in_inventory
		base_chance = base_chance*0.98
	endif
	if !actor_alias.is_bounded
		if actor_alias.has_weapon > 0.0
			base_chance = base_chance*(1.0-(0.02*actor_alias.has_weapon))
		elseif actor_alias.has_weapon_in_inventory
			base_chance = base_chance*0.99
		endif
		;LogTrace("Afraid chance="+base_chance+" has weapon "+actor_alias.has_weapon)
	endif
	
	if actor_alias.is_in_dungeon
		base_chance = base_chance*1.2
		;LogTrace("Afraid chance="+base_chance+" is in a dungeon")
	endif
	if actor_alias.is_bounded
		base_chance += 0.2
		;LogTrace("Afraid chance="+base_chance+" is bounded")
	endif

	Float chance = base_chance * (1.0-fear_training / 100.0)
	;LogTrace("Afraid chance="+chance+" fear training = "+fear_training)
	;LogTrace("Afraid chance="+chance)
	return chance
EndFunction

Float __chance_afraid_spontaneous = 0.0
Function SetChanceAfraidSpontaneous()
	__chance_afraid_spontaneous = __chance_afraid*ChanceRangeLow(fear_training, 0.0, 100.0)
EndFunction

Float __chance_scared = 0.0
Function SetChanceScared()
	__chance_scared = ChanceScared()
EndFunction
float Function GetChanceScared()
	__chance_scared = ChanceScared()
	return __chance_scared
EndFunction
Float Function ChanceScared()
	; -=TAK=- Make use of personnality traits in formula
	; scared = fear
	Float base_chance = MOD_Fearfulness
	if base_chance < 0.34 ; Resistant to fear
		;LogTrace("Scared chance=0 resistant to fear")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to fear
		base_chance = base_chance*1.2
	endif
	
	if actor_alias.has_armor > 0.0
		base_chance = base_chance*(1.0-(0.01*actor_alias.has_armor))
	elseif actor_alias.has_armor_in_inventory || actor_alias.has_shield_in_inventory
		base_chance = base_chance*0.99
	endif
	if !actor_alias.is_bounded
		if actor_alias.has_weapon > 0.0
			base_chance = base_chance*(1.0-(0.02*actor_alias.has_weapon))
		elseif actor_alias.has_weapon_in_inventory
			base_chance = base_chance*0.98
		endif
		;LogTrace("Afraid chance="+base_chance+" has weapon "+actor_alias.has_weapon)
	endif
	if actor_alias.is_in_dungeon
		base_chance = base_chance*1.2
	endif
	if actor_alias.is_bounded
		base_chance += 0.2
		;LogTrace("Afraid chance="+base_chance+" is bounded")
	endif

	Float chance = base_chance * (0.2+fear_training / 80.0) * (1.0-resignation / 120.0)
	;LogTrace("Scared chance "+name+" "+chance+" fear modifier = "+base_chance+" fear training = "+fear_training)
	;LogTrace("Scared chance="+chance)
	return chance
EndFunction

Float __chance_terrified = 0.0
Function SetChanceTerrified()
	__chance_terrified = ChanceTerrified()
EndFunction
float Function GetChanceTerrified()
	__chance_terrified = ChanceTerrified()
	return __chance_terrified
EndFunction
Float Function ChanceTerrified()
	; -=TAK=- Make use of personnality traits in formula
	; terrified = fear + sorrow
	Float base_chance = MOD_Fearfulness
	if MOD_Prudent > 0.5
		base_chance += MOD_Prudent-(0.5)
	else
		base_chance -= 0.5-MOD_Prudent
	endif
	if base_chance < 0.34 ; Resistant to terror
		;LogTrace("Terrified chance=0 resistant to terror")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to fear
		base_chance = base_chance*1.2
	endif
	
	if actor_alias.is_in_dungeon
		base_chance = base_chance*1.2
	endif

	Float chance = base_chance * (1.0 - fear_training / 100.0) * (1.0 - humiliation / 200.0)
	;LogTrace("Terrified chance "+name+" "+chance+" fear modifier = "+base_chance+" fear training = "+fear_training)
	;LogTrace("Terrified chance="+chance)
	return chance
EndFunction

Float __chance_crushed = 0.0
Function SetChanceCrushed()
	;LogTrace("SetChanceCrushed was "+__chance_crushed)
	__chance_crushed = ChanceCrushed()
EndFunction
float Function GetChanceCrushed()
	__chance_crushed = ChanceCrushed()
	return __chance_crushed
EndFunction
Float Function ChanceCrushed()
	; -=TAK=- Make use of personnality traits in formula
	if is_player_actor && !is_slave
		return 0.0
	endif
	Float base_chance = MOD_Prudent
	if MOD_Discipline > 0.5
		base_chance -= MOD_Discipline-(0.5)
	else
		base_chance += 0.5-MOD_Discipline
	endif
	if base_chance < 0.34 ; Resistant to sorrow
		;LogTrace("Crushed chance=0 resistant to sorrow")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to sorrow
		base_chance = base_chance*1.2
	endif
	if actor_alias.is_in_city
		base_chance = base_chance*1.2
	endif
	if actor_alias.is_in_dungeon
		base_chance = base_chance*1.2
	endif
	
	Float chance = base_chance * (1.0-resignation / 100.0)
	;LogTrace("Crushed chance "+name+"  "+chance+" sorrow modifier = "+base_chance+" resignation = "+resignation)
	;LogTrace("Crushed chance="+chance)
	return chance
EndFunction

Float __chance_sad = 0.0
Function SetChanceSad()
	__chance_sad = ChanceSad()
EndFunction
float Function GetChanceSad()
	__chance_sad = ChanceSad()
	return __chance_sad
EndFunction
Float Function ChanceSad()
	; -=TAK=- Make use of personnality traits in formula
	if is_player_actor && !is_slave
		return 0.0
	endif
	Float base_chance = MOD_Prudent
	if base_chance < 0.34 ; Resistant to sorrow
		;LogTrace("Sad chance=0 resistant to sorrow")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to sorrow
		base_chance = base_chance*1.2
	endif
	if !actor_alias.is_bounded
		if actor_alias.has_armor > 0.0
			base_chance = base_chance*(1.0-(0.02*actor_alias.has_armor))
		elseif actor_alias.has_armor_in_inventory || actor_alias.has_shield_in_inventory
			base_chance = base_chance*0.98
		endif
	endif
	if is_freed_slave
		base_chance = base_chance*0.25
	endif
	
	int nshock = number_of_shock
	; Number of times before sadness should appear
	float wp = 10.0/(1.0+MOD_Humility)
	float wt = 5.0/(1.0+MOD_Discipline)
	float wr = 5.0/(1.0+MOD_Gentleness)
	float wa = 5.0/(1.0+MOD_Addict)
	float ws = 5.0/(1.0+MOD_Dependence)
	float wi = 3.0/(1.0+MOD_Rebellion) 
	float wc = 3.0/(1.0+MOD_Authority) 

	; Number of times 
	float np = (number_of_pain    - nshock*wp)
	float nr = (number_of_rape    - nshock*wr)
	float na = (number_of_drug - nshock*wa)
	float ns = (number_of_sexformoney - nshock*ws)
	float nt = (number_of_toldoff - nshock*wt)*0.5
	float ni = (number_of_insult  - nshock*wi)
	float nc = (number_of_recruitedslavers - nshock*wc)

	if np < 0.0
		np = 0.0
	endif
	if nr < 0.0
		nr = 0.0
	endif
	if na < 0.0
		na = 0.0
	endif
	if ns < 0.0
		ns = 0.0
	endif
	if nt < 0.0
		nt = 0.0
	endif
	if ni < 0.0
		ni = 0.0
	endif
	if nc < 0.0
		nc = 0.0
	endif

	float modevents = np/wp+nr/wr+na/wa+ns/ws+nt/wt+ni/wi+nc/wc
	if modevents <= 0.0
		;LogTrace("Sad chance=0 no sad events")
		return 0.0
	endif
	
	if actor_alias.is_in_dungeon
		base_chance = base_chance*1.2
	endif
	
	Float events_chance = 0.75+0.5*(modevents)
	Float chance = base_chance * events_chance * (0.2+resignation / 80.0) * ( 1.0 - humiliation / 120.0)
	;LogTrace("Sad chance "+name+"  "+chance+" sorrow modifier = "+base_chance+" events="+events_chance+" resignation = "+resignation)
	;LogTrace("Sad chance="+chance)
	return chance
EndFunction

Float __chance_sad_for_unfairness = 0.0
Function SetChanceSadForUnfairness()
	__chance_sad_for_unfairness = ChanceSadForUnfairness()
EndFunction
Float Function ChanceSadForUnfairness()
	; -=TAK=- Make use of personnality traits in formula
	Float base_chance = MOD_Prudent
	if base_chance < 0.34
		;LogTrace("Sad unfairness=0 resistant to sorrow")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to sorrow
		base_chance = base_chance*1.2
	endif
	if actor_alias.is_bounded
		base_chance = base_chance*1.33
	endif
	Float modifier = MOD_Resentment*ChanceRangeLow(resignation,0.0, 100.0)
	Float chance = base_chance * modifier * (1.0 - (resignation / 100.0))
	;LogTrace("Sad for unfairness chance "+name+" "+chance+" sorrow modifier = "+base_chance+" resignation = "+resignation)
	;LogTrace("Sad for unfairness="+chance)
	return chance
EndFunction

Float __chance_sad_for_injustice = 0.0
Function SetChanceSadForInjustice()
	__chance_sad_for_injustice = ChanceSadForInjustice()
EndFunction
Float Function ChanceSadForInjustice()
	; -=TAK=- Make use of personnality traits in formula
	Float base_chance = MOD_Prudent
	if base_chance < 0.34
		;LogTrace("Sad injustice=0 resistant to sorrow")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to sorrow
		base_chance = base_chance*1.2
	endif
	Float modifier = MOD_Empathy*ChanceRangeHigh(resignation,50.0, 100.0)
	Float chance = base_chance * modifier * (1.0 - (resignation / 100.0))
	;LogTrace("Sad for injustice chance "+name+" "+chance+" sorrow modifier = "+base_chance+" resignation = "+resignation)
	;LogTrace("Sad for injustice="+chance)
	return chance
EndFunction

Float __chance_proud = 0.0
Function SetChanceProud()
	;LogTrace("SetChanceProud was "+__chance_proud)
	__chance_proud = ChanceProud()
EndFunction
float Function GetChanceProud()
	__chance_proud = ChanceProud()
	return __chance_proud
EndFunction
Float Function ChanceProud()
	; -=TAK=- Make use of personnality traits in formula
	Float base_chance = MOD_SelfEsteem
	if base_chance < 0.34 ; Resistant to pride
		;LogTrace("Proud chance=0 resistant to pride")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to pride
		base_chance = base_chance*1.2
	endif
	if actor_alias.is_shamed
		base_chance = base_chance*0.8
	endif
	if actor_alias.is_in_city
		base_chance = base_chance*1.2
	endif
	float wy = MOD_Intimidate
	float ny = number_of_chat_personality*wy
	float wc = MOD_Hope
	float nc = number_of_ransomedslaves*wc/10.0
	float events_chance = 0.0
	if ny > 0
		events_chance = 0.25*ny/(10.0+ny)
	else
		events_chance = 0.0
	endif
	events_chance += nc
		
	Float chance = (base_chance+events_chance) * (1.0-humiliation / 100.0)
	;LogTrace("Proud chance "+name+"  "+chance+" shame modifier = "+base_chance+" humiliation = "+humiliation)
	;LogTrace("Proud chance="+chance)
	return chance
EndFunction

Float __chance_ashamed = 0.0
Function SetChanceAshamed()
	__chance_ashamed = ChanceAshamed()
	SetChanceAshamedSpontaneous()
EndFunction
float Function GetChanceAshamed()
	__chance_ashamed = ChanceAshamed()
	return __chance_ashamed
EndFunction
Float Function ChanceAshamed()
	; -=TAK=- Make use of personnality traits in formula
	if !actor_alias.is_shamed
		;LogTrace("Ashamed chance=0 not shamed")
		return 0.0
	endif
	Float base_chance = MOD_Naivety
	if base_chance < 0.34 ; Resistant to shame
		;LogTrace("Ashamed chance=0 resistant to shame")
		return 0.0
	elseif base_chance > 0.66 ; Sensitive to shame
		base_chance = base_chance*1.2
	endif
	float ws = MOD_Naivety
	float wr = MOD_Gentleness
	float ww = MOD_Dependence
	float wo = MOD_Orgasm
	float wv = MOD_Ingenuity
	float wf = MOD_Manipulation
	float wy = MOD_Humility
	float wc = MOD_Anxiety
	
	float ns = number_of_shame*ws/10.0
	float nf = number_of_flatter*wf/10.0
	float nr = number_of_rape*wr/10.0
	float nw = number_of_sexwithothers*ww/10.0
	float no = number_of_orgasm*wo/2.0
	float ny = number_of_chat_feelings*wy/5.0
	float nv = (new_sexual_experiences)*wv/2.0
	float nc = (number_of_whoredslaves)*wc/5.0
	
	float nb_events = no+nv+ns+nr+nw+nf+ny+nc
	if nb_events <= 0.0
		;LogTrace("Ashamed chance=0 no humiliating events")
		return 0.0
	endif

	if actor_alias.is_in_city
		base_chance += 0.25
	endif
		
	Float events_chance = 0.75+0.25*nb_events
	if events_chance>2.0
		events_chance = 2.0
	endif
	Float chance = base_chance * events_chance * (0.2+humiliation / 80.0) * (1.0-submission / 120.0)
	;LogTrace("Ashamed chance "+name+"  "+chance+" shame modifier = "+base_chance+" events = "+events_chance+" humiliation = "+humiliation)
	;LogTrace("Ashamed chance="+chance)
	return chance
EndFunction

Float __chance_ashamed_spontaneous = 0.0
Function SetChanceAshamedSpontaneous()
	__chance_ashamed_spontaneous = __chance_ashamed*ChanceRangeLow(humiliation,0.0, 100.0)
EndFunction

Float __chance_shock = 0.0
Function SetChanceShock()
	__chance_shock = ChanceShock()
EndFunction
float Function GetChanceShock()
	__chance_shock = ChanceShock()
	return __chance_shock
EndFunction
Float Function ChanceShock()
	int nshock = number_of_shock + number_of_broken + number_of_brainwashed
	;LogTrace("Shock N "+nshock+" = nshock "+number_of_shock+" + nbroken "+number_of_broken+" + nbrainwashed "+number_of_brainwashed)
	; Number of times before a shock should appear
	;LogTrace("Shock N h "+MOD_Humility+" n "+MOD_Naivety+" c "+MOD_Consideration+" g "+MOD_Gentleness+" a "+MOD_Authority+" d "+MOD_Diligent)
	;LogTrace("Shock N d "+MOD_Discipline+" o "+MOD_Organized+" h "+MOD_Hope+" r "+MOD_Rebellion+" m "+MOD_Manipulation)
	;LogTrace("Shock N i "+MOD_Ingenuity+" c "+MOD_Creativity+" e "+MOD_Empathy+" d "+MOD_Dependence)
	float wp = 30.0/(1.0+MOD_Humility)
	float wb = 30.0/(1.0+MOD_Sociability)
	float ws = 15.0/(1.0+MOD_Naivety)
	float wx = 20.0/(1.0+MOD_Consideration)
	float wr = 20.0/(1.0+MOD_Gentleness)
	float wa = 20.0/(1.0+MOD_Addict) 
	float wo = 20.0/(1.0+MOD_Authority) 
	float wm = 20.0/(1.0+MOD_Diligent) 
	float wt = 20.0/(1.0+MOD_Discipline)
	float wz = 30.0/(1.0+MOD_Organized) 
	float wc = 20.0/(1.0+MOD_Hope) 
	float wi = 10.0/(1.0+MOD_Rebellion) 
	float wf = 10.0/(1.0+MOD_Manipulation) 
	float wv = 1.0/(1.0+MOD_Ingenuity) 
	float wk = 10.0/(1.0+MOD_Creativity) 
	float wy = 30.0/(1.0+MOD_Empathy) 
	float ww = 30.0/(1.0+MOD_Dependence) 
	; Number of times punished
	float np = (number_of_pain    - nshock*wp)
	float nb = (number_of_bondage - nshock*wb)
	float ns = (number_of_shame   - nshock*ws)*0.5
	float nx = (number_of_sex     - nshock*wx)*0.5
	float nr = (number_of_rape    - nshock*wr)
	float na = (number_of_drug - nshock*wa)
	float no = (number_of_sexwithothers    - nshock*wo)
	float nm = (number_of_sexformoney    - nshock*wm)
	float nt = (number_of_toldoff - nshock*wt)*0.5
	float nz = (number_of_praise  - nshock*wz)*0.5
	float nc = (number_of_comfort - nshock*wc)*0.5
	float ni = (number_of_insult  - nshock*wi)
	float nf = (number_of_flatter - nshock*wf)
	float nv = (new_sexual_experiences - nshock*wv)
	float nk = (number_of_kinktrigger  - nshock*wk)
	float ny = (number_of_chat_feelings - nshock*wy)*0.5
	float nw = (number_of_chat_personality - nshock*ww)*0.5
	if np < 0.0
		np = 0.0
	endif
	if nb < 0.0
		nb = 0.0
	endif
	if ns < 0.0
		ns = 0.0
	endif
	if nx < 0.0
		nx = 0.0
	endif
	if nr < 0.0
		nr = 0.0
	endif
	if na < 0.0
		na = 0.0
	endif
	if no < 0.0
		no = 0.0
	endif
	if nm < 0.0
		nm = 0.0
	endif
	if nk < 0.0
		nk = 0.0
	endif
	if nt < 0.0
		nt = 0.0
	endif
	if nz < 0.0
		nz = 0.0
	endif
	if ny < 0.0
		ny = 0.0
	endif
	if nw < 0.0
		nw = 0.0
	endif
	if nc < 0.0
		nc = 0.0
	endif
	if ni < 0.0
		ni = 0.0
	endif
	if nf < 0.0
		nf = 0.0
	endif
	if nv < 0.0
		nv = 0.0
	endif
	;LogTrace("Shock N pain "+number_of_pain+" shame "+number_of_shame+" sex "+number_of_sex+" rape "+number_of_rape+" others "+number_of_sexwithothers+" money "+number_of_sexformoney)
	;LogTrace("Shock N toldoff "+number_of_toldoff+" praise "+number_of_praise+" comfort "+number_of_comfort+" insult "+number_of_insult+" flatter "+number_of_flatter)
	;LogTrace("Shock N new "+new_sexual_experiences+" kink "+number_of_kinktrigger+" feelings "+number_of_chat_feelings+" chat "+number_of_chat_personality)
	;LogTrace("Shock N n = "+np+" "+nb+" "+ns+" "+nx+" "+nr+" "+no+" "+nm)
	;LogTrace("Shock N n = "+nt+" "+nz+" "+nc+" "+ni+" "+nf)
	;LogTrace("Shock N n = "+nv+" "+nk+" "+ny+" "+nw)
	;LogTrace("Shock N w = "+wp+" "+ws+" "+wx+" "+wr+" "+wo+" "+wm)
	;LogTrace("Shock N w = "+wt+" "+wz+" "+wc+" "+wi+" "+wf)
	;LogTrace("Shock N w = "+wv+" "+wk+" "+wy+" "+ww)
	Float base_chance = MOD_Forgiveness
	Float mod_chance  = MOD_Prudent
	Float pnsh_chance = (np/wp+nb/wb+ns/ws+nx/wx+nr/wr+na/wa+no/wo+nm/wm+nk/wk+nt/wt+nz/wz+ny/wy+nw/ww+nc/wc+ni/wi+nf/wf+nv/wv)
	;LogTrace("Shock chance "+name+"  "+base_chance+" "+mod_chance+" "+pnsh_chance)
	if pnsh_chance <= 0.0
		;LogTrace("Shock chance=0 not enough abuse")
		return 0.0
	endif
	Float chance = mod_chance*base_chance*pnsh_chance
	;LogTrace("Shock chance "+name+"  "+base_chance+" "+mod_chance+" "+pnsh_chance+" = "+chance)
	;LogTrace("Shock chance="+chance)
	if chance > 1.0
		return 1.0
	endif
	return chance
EndFunction

Float __chance_broken = 0.0
Function SetChanceBroken()
	__chance_broken = ChanceBroken()
EndFunction
float Function GetChanceBroken()
	__chance_broken = ChanceBroken()
	return __chance_broken
EndFunction
Float Function ChanceBroken()
	Float psub = __total_training
	Float base_chance = psub/166.6
	float nshock = (number_of_shock+number_of_broken+number_of_brainwashed)*MOD_Anxiety+number_of_drug*MOD_Addict*0.1
	float nbond = number_of_bondage*MOD_Sociability
	float nvirg = new_sexual_experiences*MOD_Naivety
	float nkink = number_of_kinktrigger*MOD_Ingenuity
	float nsex = (number_of_sex+number_of_rape+number_of_sexwithothers+number_of_sexformoney)*MOD_Manipulation
	Float multiplier = 0.01 + nvirg/10.0 + nshock/25.0 + nkink/50.0 + nbond/75.0 + nsex/100.0
	if is_freed_slave
		base_chance = base_chance*1.5
	endif
	float chance = base_chance*multiplier
	;LogTrace("Broken chance  base="+base_chance+" nvirg="+nvirg+" nshock="+nshock+" nkink="+nkink+" nsex="+nsex+" mult="+multiplier)
	;LogTrace("Broken chance="+chance)
	return chance
EndFunction

Float __chance_loyal = 0.0
Function SetChanceLoyal()
	__chance_loyal = ChanceLoyal()
EndFunction
float Function GetChanceLoyal()
	__chance_loyal = ChanceLoyal()
	return __chance_loyal
EndFunction
Float Function ChanceLoyal()
	if number_of_shock == 0 || number_of_praise == 0 || number_of_broken == 0 || !DOM01.loyalToggle
		;LogTrace("Loyal chance=0 not enough shocks or deactivated")
		return 0.0
	endif
	float xtot = __total_loyal_feelings
	float ndays = timer_for_broken ; timer is in days
	if xtot <= 0.0
		if ndays <= ((7.0/(MOD_Diligent+1.0)) as int)
			;LogTrace("Loyal chance=0 not enough broken")
			return 0.0
		endif
	endif
	Float broken_bonus = 1.0 - 0.9/(ndays*MOD_Anxiety)
	if broken_bonus < 0.1
		broken_bonus = 0.1
	endif

	float modifier = 0.5*(submission+humiliation+respect_training+100.0)/400.0*(resignation+fear_training+anger_training)/300.0
	float modifier2 = 0.05*(xtot)/100.0
	modifier += modifier2

	;if resignation < 80.0 || fear_training < 80.0 || respect_training < 80.0
	;	LogTrace("Loyal chance "+name+" = 0 ")
	;	return 0.0
	;endif
	;if submission < 60.0 || humiliation < 60.0 || anger_training < 60.0
	;	LogTrace("Loyal chance "+name+" = 0 ")
	;	return 0.0
	;endif
	float np = number_of_praise*MOD_Hope/10.0
	float ny = number_of_chat_personality*MOD_Empathy/10.0
	float ns = number_of_shock*MOD_Modesty/10.0
	float nb = (number_of_broken+number_of_brainwashed)*MOD_Sincerity/3.0
	float nt1 = number_of_trainee*MOD_Insensitivity/10.0
	float nt2 = number_of_trainer*MOD_Criminality/3.0

	Float events_chance = (np+ny+ns+nb)*(nt1+nt2+1.0)
	Float base_chance = MOD_Manipulation*__chance_broken*DOM01.DOMPlayerAlias.GetDeceiverModifier()
	if actor_alias.has_armor > 0.0
		base_chance = base_chance*(1.0+0.01*actor_alias.has_armor)
	elseif actor_alias.has_armor_in_inventory || actor_alias.has_shield_in_inventory
		base_chance = base_chance*1.01
	endif
	if actor_alias.has_weapon > 0.0
		base_chance = base_chance*(1.0+0.01*actor_alias.has_weapon)
	elseif actor_alias.has_weapon_in_inventory
		base_chance = base_chance*1.01
	endif
	if is_freed_slave
		base_chance = base_chance*1.5
	endif
	Float mod_chance = (0.1+MOD_Impressionable)*modifier
	Float sub_chance = 1.0 + loyal_worship/1000.0 + loyal_absolution/1000.0 + loyal_devotion/1000.0
	Float chance = mod_chance*base_chance*events_chance*(anger_training / 100.0)*broken_bonus*sub_chance
	;LogTrace("Loyal chance "+name+" broken days="+ndays+" broken bonus="+broken_bonus+"  events="+events_chance+" sub="+sub_chance+" mod="+modifier+" mod2="+modifier2+" base="+base_chance+" mod="+mod_chance+" -> "+chance+" n = "+np+" "+ns+" w = "+wp+" "+ws)
	;LogTrace("Loyal chance="+chance)
	if chance > 1.0
		return 1.0
	endif
	return chance
EndFunction

Float __chance_charmed = 0.0
Function SetChanceCharmed()
	__chance_charmed = ChanceCharmed()
EndFunction
float Function GetChanceCharmed()
	__chance_charmed = ChanceCharmed()
	return __chance_charmed
EndFunction
Float Function ChanceCharmed()
	if !is_love_interest || !DOM01.inloveToggle
		;LogTrace("Inlove chance=0 not love interest or deactivated")
		return 0.0
	endif
	float xtot = __total_love_feelings
	float ndays = timer_for_broken ; timer is in days
	if xtot <= 0.0
		if number_of_sex == 0 || number_of_praise == 0 || number_of_flatter == 0
			;LogTrace("Love chance=0 not enough praising")
			return 0.0
		endif
	endif
	Float trauma_bonus
	float div = ndays*MOD_Panic
	if div > 0
		trauma_bonus = 1.0 - 0.9/(ndays*MOD_Panic)
		if trauma_bonus < 0.1
			trauma_bonus = 0.1
		endif
	else
		trauma_bonus = 0.1
	endif

	int rank = akRef.GetRelationshipRank(PlayerRef)
	float chance_rel = 1.0+(rank as float)*0.05
	float modifier = (loyal_absolution+loyal_devotion+loyal_worship)/300.0*chance_rel
	
	float wp = MOD_Gentleness
	float wx = MOD_Consideration
	float wo = MOD_Orgasm
	float wf = MOD_Manipulation
	float wv = MOD_Ingenuity
	float wb = MOD_Sincerity
	float wy = MOD_Empathy
	float wk = MOD_Creativity
	float wc = MOD_Dependence
	float ws = MOD_Sociability
	float wg = MOD_Forgiveness
	float nf = number_of_flatter*wf/3.0
	float np = number_of_praise*wp/10.0
	float ny = (number_of_chat_feelings+number_of_chat_personality)*wy/10.0
	float no = number_of_orgasm*wo/3.0
	float nx = number_of_sex*wx/3.0
	float ns = number_of_bondage*ws/5.0
	float nk = number_of_kinktrigger*wk/3.0
	float nc = number_of_comfort*wc/3.0
	float nv = (new_sexual_experiences)*wv
	float nb = (number_of_broken+number_of_brainwashed)*wb/3.0
	float ng = number_of_insult/3.0+number_of_pain/10.0+number_of_rape/3.0+number_of_toldoff/3.0
	
	Float events_chance = (np+ny+no+nx+nf)*(nk+nv+nb+nc+ns)
	if ng > 0 ; bad events modifier
		events_chance = events_chance*wg/ng
	endif
	Float base_chance = MOD_Sentimentality*modifier*DOM01.DOMPlayerAlias.GetDeceiverModifier()
	if actor_alias.has_weapon > 0.0
		base_chance = base_chance+0.02*actor_alias.has_weapon
	elseif actor_alias.has_weapon_in_inventory
		base_chance = base_chance+0.02
	endif
	if is_freed_slave
		base_chance = base_chance*1.5
	endif
	;LogTrace("charmed chance="+chance+" ns="+ns+" nt="+nt+" events="+modevents+" base="+base_chance)
	;LogTrace("charmed chance="+chance)

	Float mod_chance = (0.1+MOD_Hope)
	Float sub_chance = 1.0 + love_desire/1000.0 + love_admiration/1000.0 + love_fascination/1000.0
	Float chance = mod_chance*base_chance*events_chance*(0.5+anger_training / 200.0)*trauma_bonus*sub_chance
	if actor_alias.has_jewelry > 0.0 && chance > 0.66
		chance = chance*(1.0+0.1*actor_alias.has_jewelry*MOD_Greed)
	endif
	if actor_alias.has_gold > 0.0 && chance > 0.84
		chance = chance*(1.0+0.0002*actor_alias.has_gold*MOD_Greed)
	endif
	;LogTrace("Inlove chance "+name+"  days broken="+ndays+" broken bonus="+trauma_bonus+"  events="+events_chance+" sub="+sub_chance+" mod="+modifier+" mod2="+modifier2+" base="+base_chance+" mod="+mod_chance+" -> "+chance+" n = praise "+np+" orgasm = "+no+" sex "+nx+" shame "+ns+" rape "+nr+" v "+nv)
	;LogTrace("Inlove chance="+chance)
	return chance
EndFunction

Float __chance_inlove = 0.0
Function SetChanceInlove()
	__chance_inlove = ChanceInlove()
EndFunction
float Function GetChanceInlove()
	__chance_inlove = ChanceInlove()
	return __chance_inlove
EndFunction
Float Function ChanceInlove()
	if !is_love_interest || !DOM01.inloveToggle || is_player_actor
		;LogTrace("Inlove chance=0 not love interest or deactivated")
		return 0.0
	endif
	float xtot = __total_love_feelings
	float ndays = timer_for_broken ; timer is in days
	if xtot <= 0.0
		if number_of_shock == 0 || number_of_broken == 0 || number_of_praise == 0
			;LogTrace("Love chance=0 not enough shocks")
			return 0.0
		endif
		if (number_of_sex == 0 && number_of_flatter == 0)
			;LogTrace("Love chance=0 not enough flirting")
			return 0.0
		endif
		float mindays = 3.5/(MOD_Manipulation+0.5)
		if ndays < mindays
			;LogTrace("Love chance=0 not enough broken ndays="+ndays+"/"+mindays)
			return 0.0
		endif
	endif
	Float broken_bonus
	float div = ndays*MOD_Anxiety
	if div > 0
		broken_bonus = 1.0 - 0.9/(ndays*MOD_Anxiety)
		if broken_bonus < 0.1
			broken_bonus = 0.1
		endif
	else
		broken_bonus = 0.1
	endif

	float modifier = 0.5*(submission+humiliation+respect_training)/300.0*(resignation+fear_training+anger_training+100.0)/400.0
	float modifier2 = 0.1*(xtot)/100.0*(__total_loyal_feelings)/100.0
	modifier += modifier2
	
	float wp = MOD_Hope
	float ws = MOD_Naivety
	float wa = MOD_Sociability
	float wx = MOD_Consideration
	float wr = MOD_Gentleness
	float wo = MOD_Orgasm
	float wf = MOD_Manipulation
	float wk = MOD_Creativity
	float wv = MOD_Ingenuity
	float wb = MOD_Sincerity
	float wy = MOD_Empathy
	float nf = number_of_flatter*wf/3.0
	float np = number_of_praise*wp/10.0
	float ny = (number_of_chat_feelings+number_of_chat_personality)*wy/10.0
	float no = number_of_orgasm*wo/3.0
	float nx = (number_of_sex-number_of_rape)*wx/3.0
	float nk = (number_of_kinktrigger)*wk/3.0
	float ns = number_of_shame*ws/10.0 + number_of_bondage*wa/10.0
	float nr = number_of_rape*wr/10.0
	float nv = (new_sexual_experiences)*wv
	float nb = (number_of_broken+number_of_brainwashed)*wb/3.0
	if nx < 0.0
		nx = 0.0
	endif
	
	Float events_chance = (np+ny+no+nx+nf)*(nk+ns+nr+nv+nb)
	Float base_chance = MOD_Sentimentality*modifier*__chance_broken*DOM01.DOMPlayerAlias.GetDeceiverModifier()
	if is_freed_slave
		base_chance = base_chance*1.5
	endif
	Float mod_chance = (0.1+MOD_Impressionable)
	Float sub_chance = 1.0 + love_desire/1000.0 + love_admiration/1000.0 + love_fascination/1000.0
	Float chance = mod_chance*base_chance*events_chance*(anger_training / 100.0)*broken_bonus*sub_chance
	if actor_alias.has_jewelry > 0.0 && chance > 0.66
		chance = chance*(1.0+0.1*actor_alias.has_jewelry*MOD_Greed)
	endif
	if actor_alias.has_gold > 0.0 && chance > 0.84
		chance = chance*(1.0+0.0002*actor_alias.has_gold*MOD_Greed)
	endif
	;LogTrace("Inlove chance "+name+"  days broken="+ndays+" broken bonus="+broken_bonus+"  events="+events_chance+" sub="+sub_chance+" mod="+modifier+" mod2="+modifier2+" base="+base_chance+" mod="+mod_chance+" -> "+chance+" n = praise "+np+" orgasm = "+no+" sex "+nx+" shame "+ns+" rape "+nr+" v "+nv)
	;LogTrace("Inlove chance="+chance)
	return chance
EndFunction

Float __chance_jealous = 0.0
Function SetChanceJealous()
	__chance_jealous = ChanceJealous()
EndFunction
float Function GetChanceJealous()
	__chance_jealous = ChanceJealous()
	return __chance_jealous
EndFunction
Float Function ChanceJealous()
	if __chance_inlove == 0.0 || !DOM01.jealousyToggle
		;LogTrace("Jealous chance=0 not inlove or deactivated")
		return 0.0
	endif
	if loyal_absolution >= 100.0 && love_admiration >= 100.0
		;LogTrace("Jealous chance=0 too much inlove")
		return 0.0
	endif
	float modifier = 0.5*(submission+respect_training+anger_training)/300.0*(resignation+fear_training+humiliation+100.0)/400.0
	
	float wp = MOD_Laborious
	float wi = MOD_Daring
	float wx = MOD_Rebellion
	float wc = MOD_Forgiveness
	float wf = MOD_Dependence
	float wo = MOD_Anxiety

	float np = (number_of_shame*0.25+number_of_toldoff)*wp
	float ni = (number_of_insult+number_of_threat+number_of_chat_personality)*wi
	float nx = (number_of_rape*0.5+ number_of_orgasm+number_of_shock)*wx
	float no = (number_of_sexwithothers/3.0)*wo
	float nc = (number_of_player_chat)/wc-np-ni
	float nf = (number_of_player_fling)*wf-nx+no
	if nc < 0.0
		nc = 0.0
	endif
	if nf < 0.0
		nf = 0.0
	endif
	
	; Rival info
	float mod_rival = 1.0
	DOM_Actor rival_actor = actor_alias.GetMyRival()
	if rival_actor != None			
		DOM_Mind rival = rival_actor.mind
		float r_np = rival.number_of_pain+rival.number_of_shame+rival.number_of_toldoff+rival.number_of_insult
		float r_na = rival.number_of_sex+rival.number_of_praise+rival.number_of_comfort+rival.number_of_flatter+rival.number_of_chat_feelings+rival.number_of_chat_personality
		if r_na >= 0.0
			mod_rival = r_na/r_np
		endif
	endif

	; if there are no jealous event, the chance will be the highest
	; This is because the slave will assume the worst
	; After 1 sex event or 2 flirts, trust will be restored and chance will be 0
	; After that chance goes up for each sex or flirt
	Float jealous_chance = 1.0
	if nc > 0.0 
		jealous_chance -= 0.5/nc
	endif
	if nf > 0.0 
		jealous_chance -= 1.0/nf
	endif
	Float base_chance = MOD_Dependence*modifier*__chance_inlove
	if actor_alias.is_bounded
		base_chance = base_chance*0.66
	endif
	Float mod_chance = 0.1+nc+nf
	Float sub_chance = (1.0 - (submission / 1000.0)) * (1.0 - (loyal_absolution/100.0))
	Float chance = mod_chance*base_chance*jealous_chance*sub_chance
	;LogTrace("Jealous chance "+name+"  "+jealous_chance+"  "+base_chance+" "+mod_chance+" "+sub_chance+" = "+chance+" n = scold "+np+" insult = "+ni+" rape "+nx+" chat "+nc+" fling "+nf+" w = "+wp+" "+wi+" "+wx)
	;LogTrace("Jealous chance="+chance)
	return chance
EndFunction

Float __chance_depressed = 0.0
Function SetChanceDepressed()
	__chance_depressed = ChanceDepressed()
EndFunction
float Function GetChanceDepressed()
	__chance_depressed = ChanceDepressed()
	return __chance_depressed
EndFunction
Float Function ChanceDepressed()
	if __chance_inlove == 0.0
		;LogTrace("Depressed chance=0 not inlove")
		return 0.0
	endif
	if is_player_actor && !is_slave
		;LogTrace("Depressed chance=0 player sadness deactivated")
	elseif !DOM01.depressedToggle
		;LogTrace("Depressed chance=0 deactivated")
		return 0.0
	endif
	if loyal_worship >= 100.0 && love_desire >= 100.0
		;LogTrace("Depressed chance=0 too much inlove")
		return 0.0
	endif
	float modifier = 0.5*(submission+humiliation+fear_training)/300.0*(resignation+anger_training+respect_training+100.0)/400.0

	float wp = MOD_Authority
	float wi = MOD_Diligent
	float wx = MOD_SelfEsteem
	float wc = MOD_Forgiveness
	float wf = MOD_Anxiety
	float wa = MOD_Addict

	float np = (number_of_pain*0.1+number_of_insult)*wp
	float ni = (number_of_promise+number_of_comfort+number_of_chat_feelings)*wi
	float nx = (number_of_sex/3.0+number_of_orgasm+number_of_shock)/wx
	float na = (number_of_drug*0.5)*wa
	float nc = (number_of_player_chat)/wc-np-ni+na
	float nf = (number_of_player_fling)*wf-nx
	if nc < 0.0
		nc = 0.0
	endif
	if nf < 0.0
		nf = 0.0
	endif
	; if there are no jealous event, the chance will be the highest
	; This is because the slave will assume the worst
	; After 1 sex event or 2 flirts, trust will be restored and chance will be 0
	; After that chance goes up for each sex or flirt
	; Too much Narcotics might also lead to depression
	Float sad_chance = 1.0
	if nc > 0.0 
		sad_chance -= 0.5/nc
	endif
	if nf > 0.0 
		sad_chance -= 1.0/nf
	endif
	Float base_chance = MOD_Panic*modifier*__chance_inlove
	if actor_alias.is_bounded
		base_chance = base_chance*1.33
	endif
	Float mod_chance = 0.1+nc+nf
	Float sub_chance = (1.0 - (humiliation / 1000.0)) * (1.0 - (loyal_worship/100.0))
	Float chance = mod_chance*base_chance*sad_chance*sub_chance
	;LogTrace("Depressed chance "+name+"  "+sad_chance+"  "+base_chance+" "+mod_chance+" "+sub_chance+" = "+chance+" n = scold "+np+" insult = "+ni+" flatter = "+nf+" rape "+nx+" chat "+nc+" fling "+nf+" w = "+wp+" "+wi+" "+wx)
	;LogTrace("Depressed chance="+chance)
	return chance
EndFunction

Float __chance_insecure = 0.0
Function SetChanceInsecure()
	__chance_insecure = ChanceInsecure()
EndFunction
float Function GetChanceInsecure()
	__chance_insecure = ChanceInsecure()
	return __chance_insecure
EndFunction
Float Function ChanceInsecure()
	if __chance_inlove == 0.0 || !DOM01.insecureToggle
		;LogTrace("Insecure chance=0 not inlove or deactivated")
		return 0.0
	endif
	if loyal_devotion >= 100.0 && love_fascination >= 100.0
		;LogTrace("Insecure chance=0 too much inlove")
		return 0.0
	endif
	float modifier = 0.5*(humiliation+resignation+respect_training)/300.0*(anger_training+fear_training+submission+100.0)/400.0

	float wp = MOD_Consideration
	float wi = MOD_Creativity
	float wx = MOD_SelfEsteem
	float wc = MOD_Dependence
	float wf = MOD_Anxiety
	float wm = MOD_Diligent

	float np = (number_of_praise*0.5+number_of_shame)*wp
	float ni = (number_of_flatter+number_of_comfort)*wi
	float nx = (number_of_sex/3.0+number_of_orgasm+number_of_rape*0.5)*wx
	float nm = (number_of_sexformoney/3.0)*wm
	float nc = (number_of_player_chat+number_of_chat_feelings)*wc-np-ni
	float nf = (number_of_player_fling+number_of_chat_personality)*wf-nx+nm
	if nc < 0.0
		nc = 0.0
	endif
	if nf < 0.0
		nf = 0.0
	endif
	; if there are no jealous event, the chance will be the highest
	; This is because the slave will assume the worst
	; After 1 sex event or 2 flirts, trust will be restored and chance will be 0
	; After that chance goes up for each sex or flirt
	Float sad_chance = 1.0
	if nc > 0.0 
		sad_chance -= 0.5/nc
	endif
	if nf > 0.0 
		sad_chance -= 1.0/nf
	endif
	Float base_chance = MOD_Humility*modifier*__chance_inlove
	Float mod_chance = 0.1+nc+nf
	Float sub_chance = (1.0 - (respect_training / 1000.0)) * (1.0 - (loyal_devotion/100.0))
	if actor_alias.is_shamed
		base_chance *= 1.25
	endif
	Float chance = mod_chance*base_chance*sad_chance*sub_chance
	;LogTrace("Insecure chance "+name+"  "+sad_chance+"  "+base_chance+" "+mod_chance+" "+sub_chance+" = "+chance+" n = scold "+np+" insult = "+ni+" flatter = "+nf+" rape "+nx+" chat "+nc+" fling "+nf+" w = "+wp+" "+wi+" "+wx)
	;LogTrace("Insecure chance="+chance)
	return chance
EndFunction

Float __chance_recover_from_angry = 0.0
Function SetChanceRecoverFromAngry()
	__chance_recover_from_angry = ChanceRecoverFromAngry()
EndFunction
Float Function ChanceRecoverFromAngry()
	Float base_chance = MOD_Modesty
	Float chance = base_chance * (1.1 - (anger_training / 100.0))
	;LogTrace("Recovery from angry chance="+chance)
	return chance
EndFunction

Float __chance_recover_from_afraid = 0.0
Function SetChanceRecoverFromAfraid()
	__chance_recover_from_afraid = ChanceRecoverFromAfraid()
EndFunction
Float Function ChanceRecoverFromAfraid()
	; -=TAK=- Make use of personnality traits in formula
	Float base_chance =  1.2-MOD_Forgiveness
	if base_chance < 0.1
		base_chance = 0.1
	endif
	Float chance = base_chance * (1.1 - (fear_training / 100.0))
	;LogTrace("Recovery from afraid chance "+name+" base "+base_chance+" now "+chance)
	;LogTrace("Recovery from afraid chance="+chance)
	return chance
EndFunction

Float __chance_recover_from_sad = 0.0
Function SetChanceRecoverFromSad()
	__chance_recover_from_sad = ChanceRecoverFromSad()
EndFunction
Float Function ChanceRecoverFromSad()
	; -=TAK=- Make use of personnality traits in formula
	Float base_chance = MOD_Modesty+0.1
	Float chance = base_chance * (1.1 - (resignation / 100.0))
	;LogTrace("Recovery from sad chance "+name+" base "+base_chance+" now "+chance)
	;LogTrace("Recovery from sad chance="+chance)
	return chance
EndFunction

Float __chance_recover_from_ashamed = 0.0
Function SetChanceRecoverFromAshamed()
	__chance_recover_from_ashamed = ChanceRecoverFromAshamed()
EndFunction
Float Function ChanceRecoverFromAshamed()
	; -=TAK=- Make use of personnality traits in formula
	Float base_chance = MOD_Modesty+0.1
	Float chance = base_chance * (1.1 - (humiliation / 100.0))
	;LogTrace("Recovery from ashamed chance "+name+" base "+base_chance+" now "+chance)
	;LogTrace("Recovery from ashamed chance="+chance)
	return chance
EndFunction

Float __chance_recover_from_shock = 0.0
Function SetChanceRecoverFromShock()
	__chance_recover_from_shock = ChanceRecoverFromShock()
EndFunction
Float Function ChanceRecoverFromShock()
	; -=TAK=- Make use of personnality traits in formula
	Float base_chance =  (1.2-MOD_Forgiveness)
	if base_chance < 0.1
		base_chance = 0.1
	endif
	float cool_chance = MOD_Modesty
	Float chance = base_chance * cool_chance
	;LogTrace("Recovery from shock chance="+chance)
	return chance
EndFunction

Float __chance_recover_from_broken = 0.0
Function SetChanceRecoverFromBroken()
	__chance_recover_from_broken = ChanceRecoverFromBroken()
EndFunction
Float Function ChanceRecoverFromBroken()
	; -=TAK=- Make use of personnality traits in formula
	Float base_chance =  (1.2-MOD_Forgiveness)
	if base_chance < 0.1
		base_chance = 0.1
	endif
	float smart_chance = 1.2-MOD_Manipulation
	if smart_chance < 0.1
		smart_chance = 0.1
	endif
		
	float training_mod  = 1.1-(__total_training)/100.0
	Float chance = base_chance * smart_chance * training_mod
	;LogTrace("Recovery from broken chance "+name+" base "+base_chance+" cool "+smart_chance+" training "+training_mod+" = "+chance)
	;LogTrace("Recovery from broken chance="+chance)
	return chance
EndFunction

Float __chance_recover_from_depressed = 0.0
Function SetChanceRecoverFromDepressed()
	__chance_recover_from_depressed = ChanceRecoverFromDepressed()
EndFunction
Float Function ChanceRecoverFromDepressed()
	; -=TAK=- Make use of personnality traits in formula
	Float base_chance = MOD_Modesty+0.1
	Float chance = base_chance * (1.6 - (submission / 200.0))
	;LogTrace("Recovery from depressed chance "+name+" base "+base_chance+" now "+chance)
	;LogTrace("Recovery from depressed chance="+chance)
	return chance
EndFunction

Float __chance_recover_from_insecure = 0.0
Function SetChanceRecoverFromInsecure()
	__chance_recover_from_insecure = ChanceRecoverFromInsecure()
EndFunction
Float Function ChanceRecoverFromInsecure()
	; -=TAK=- Make use of personnality traits in formula
	Float base_chance = MOD_Modesty+0.1
	Float chance = base_chance * (1.6 - (humiliation / 200.0))
	;LogTrace("Recovery from insecure chance "+name+" base "+base_chance+" now "+chance)
	;LogTrace("Recovery from insecure chance="+chance)
	return chance
EndFunction

Float __chance_recover_from_jealous = 0.0
Function SetChanceRecoverFromJealous()
	__chance_recover_from_jealous = ChanceRecoverFromJealous()
EndFunction
Float Function ChanceRecoverFromJealous()
	; -=TAK=- Make use of personnality traits in formula
	if __chance_jealous <= 0.0
		;LogTrace("Recovery jealous chance=1")
		return 1.0
	endif
	Float base_chance = MOD_Modesty+0.1
	Float chance = base_chance * (1.6 - (anger_training / 200.0))
	;LogTrace("Recovery from jealous chance "+name+" base "+base_chance+" now "+chance)
	;LogTrace("Recovery from jealous chance="+chance)
	return chance
EndFunction

Float __chance_respectful = 0.0
Function SetChanceRespectful()
	__chance_respectful = ChanceRespectful()
EndFunction
float Function GetChanceRespectful()
	__chance_respectful = ChanceRespectful()
	return __chance_respectful
EndFunction
Float Function ChanceRespectful()
	Float respect_multiplier = MOD_Authority
	Float base_chance = (((respect_training + 10.0) * 1.6) / 110.0)
	Float chance = base_chance*respect_multiplier
	;LogTrace("Respectful chance base "+base_chance+" now "+chance)
	chance = ( chance * ChanceRangeHigh(submission, 0.0, 100.0))
	;LogTrace("Respectful chance="+chance)
	return chance
EndFunction

Float __chance_fighting = 0.0
Function SetChanceFightForPlayer()
	__chance_fighting = ChanceFightForPlayer()
EndFunction
float Function GetChanceFightForPlayer()
	__chance_fighting = ChanceFightForPlayer()
	return __chance_fighting
EndFunction
Float Function ChanceFightForPlayer()
	Float base_chance = 0.1+MOD_Diligent + (combat_training / 200.0)
	float res_chance = (0.5 + (ChanceRangeHigh(resignation, 0.0, 100.0) * 0.7))
	float chance = base_chance*res_chance
	;LogTrace("Fight chance="+base_chance+" * "+res_chance+" * "+psh_chance+" = "+chance)
	;LogTrace("Fight chance="+chance)
	return chance
EndFunction

Float __chance_punished_multiplier = 0.0
Function SetChancePunishedMultiplier()
	__chance_punished_multiplier = ChancePunishedMultiplier()
	SetChanceRecentlyPunished()
EndFunction
Float Function ChancePunishedMultiplier()
	Float chance_multiplier = (1.0-MOD_Resentment) ; MOD_Humility
	Float resignation_multiplier =  (1.0 - (resignation / 100.0)) ; 0.5+resignation / 200.0
	Float chance = chance_multiplier*resignation_multiplier
	;LogTrace("Recovery punished multiplier="+chance)
	return chance
EndFunction

Float __chance_recently_punished_inverted = 0.0
Float __chance_recently_punished = 0.0
Function SetChanceRecentlyPunished()
	__chance_recently_punished_inverted = ChanceRecentlyPunishedInverted()
	__chance_recently_punished          = ChanceRecentlyPunished()
EndFunction
Float Function ChanceRecentlyPunishedInverted()
	Float base_chance = ChanceDecayOverTime(ticks_since_last_punished, 60.0, 1.0, 0.0)
	Float chance = 1.0-base_chance*__chance_punished_multiplier
	if chance < 0.0
		chance = 0.0
	endif
	;LogTrace("Recently punished inverted="+chance)
	return chance
EndFunction
Float Function ChanceRecentlyPunished()
	Float base_chance = ChanceDecayOverTime(ticks_since_last_punished, 30.0, 1.0, 0.0)
	Float chance = base_chance*__chance_punished_multiplier
	if chance > 1.0
		chance = 1.0
	endif
	;LogTrace("Recently punished chance="+chance)
	return chance
EndFunction

int registered_updates1 = 0x7fffffff
int registered_updates2 = 0x7fffffff

Function RegisterForUpdateChanceAngry()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x1)
	;LogTrace("RegisterForUpdateChanceAngry: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceAfraid()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x2)
	;LogTrace("RegisterForUpdateChanceAfraid: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceTerrified()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x4)
	;LogTrace("RegisterForUpdateChanceTerrified: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceScared()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x8)
	;LogTrace("RegisterForUpdateChanceScared: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceAshamed()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x10)
	;LogTrace("RegisterForUpdateChanceAshamed: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceSad()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x20)
	;LogTrace("RegisterForUpdateChanceSad: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceShock()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x40)
	;LogTrace("RegisterForUpdateChanceShock: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceBroken()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x80)
	RegisterForUpdateChanceLoyal()
	RegisterForUpdateChanceInlove()
	;LogTrace("RegisterForUpdateChanceBroken: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceLoyal()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x100)
	;LogTrace("RegisterForUpdateChanceLoyal: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceInlove()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x200)
	RegisterForUpdateChanceJealous()
	RegisterForUpdateChanceDepressed()
	RegisterForUpdateChanceInsecure()
	;LogTrace("RegisterForUpdateChanceInlove: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceJealous()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x400)
	;LogTrace("RegisterForUpdateChanceJealous: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceDepressed()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x800)
	;LogTrace("RegisterForUpdateChanceDepressed: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceAngryForUnfairness()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x1000)
	;LogTrace("RegisterForUpdateChanceAngryForUnfairness: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceAngryForInjustice()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x2000)
	;LogTrace("RegisterForUpdateChanceAngryForInjustice: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceSadForUnfairness()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x4000)
	;LogTrace("RegisterForUpdateChanceSadForUnfairness: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceSadForInjustice()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x8000)
	;LogTrace("RegisterForUpdateChanceSadForInjustice: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceRecoverFromAngry()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x10000)
	;LogTrace("RegisterForUpdateChanceRecoverFromAngry: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceRecoverFromAfraid()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x20000)
	;LogTrace("RegisterForUpdateChanceRecoverFromAfraid: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceRecoverFromAshamed()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x40000)
	;LogTrace("RegisterForUpdateChanceRecoverFromAshamed: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceRecoverFromSad()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x80000)
	;LogTrace("RegisterForUpdateChanceRecoverFromSad: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceRecoverFromShock()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x100000)
	;LogTrace("RegisterForUpdateChanceRecoverFromShock: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceRecoverFromBroken()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x200000)
	;LogTrace("RegisterForUpdateChanceRecoverFromBroken: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceRecoverFromJealous()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x400000)
	;LogTrace("RegisterForUpdateChanceRecoverFromJealous: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceRecoverFromDepressed()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x800000)
	;LogTrace("RegisterForUpdateChanceRecoverFromDepressed: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceRespectful()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x1000000)
	;LogTrace("RegisterForUpdateChanceRespectful: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceFightForPlayer()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x2000000)
	;LogTrace("RegisterForUpdateChanceFightForPlayer: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChancePunishedMultiplier()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x4000000)
	;LogTrace("RegisterForUpdateChancePunishedMultiplier: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceHappy()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x8000000)
	;LogTrace("RegisterForUpdateChanceHappy: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceInsecure()
	registered_updates1 = Math.LogicalOr(registered_updates1, 0x10000000)
	;LogTrace("RegisterForUpdateChanceInsecure: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction
Function RegisterForUpdateChanceRecoverFromInsecure()
	registered_updates2 = Math.LogicalOr(registered_updates2, 0x1)
	;LogTrace("RegisterForUpdateChanceRecoverFromInsecure: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates2))
EndFunction
Function RegisterForUpdateChanceRunAway()
	registered_updates2 = Math.LogicalOr(registered_updates2, 0x2)
	;LogTrace("RegisterForUpdateChanceRecoverFromInsecure: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates2))
EndFunction
Function RegisterForUpdateChanceRunAwayGang()
	registered_updates2 = Math.LogicalOr(registered_updates2, 0x4)
	;LogTrace("RegisterForUpdateChanceRecoverFromInsecure: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates2))
EndFunction
Function RegisterForUpdateChanceProud()
	registered_updates2 = Math.LogicalOr(registered_updates2, 0x8)
	;LogTrace("RegisterForUpdateChanceProud: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates2))
EndFunction
Function RegisterForUpdateChanceCrushed()
	registered_updates2 = Math.LogicalOr(registered_updates2, 0x10)
	;LogTrace("RegisterForUpdateChanceCrushed: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates2))
EndFunction
Function RegisterForUpdateChanceDefiant()
	registered_updates2 = Math.LogicalOr(registered_updates2, 0x20)
	;LogTrace("RegisterForUpdateChanceDefiant: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates2))
EndFunction
Function RegisterForUpdateChanceCharmed()
	registered_updates2 = Math.LogicalOr(registered_updates2, 0x40)
	;LogTrace("RegisterForUpdateChanceCharmed: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates2))
EndFunction
Function RegisterForUpdateTrainingStatus()
	registered_updates2 = Math.LogicalOr(registered_updates2, 0x80)
	;LogTrace("RegisterForUpdateTrainingStatus: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates2))
EndFunction
Function RegisterForUpdatePersonalityIndex()
	registered_updates2 = Math.LogicalOr(registered_updates2, 0x100)
	;LogTrace("RegisterForUpdatePersonalityIndex: "+name+" Update=0x"+DOM_Util.ConvertIDToHex(registered_updates2))
EndFunction

Function UpdateRegistered()
	if registered_updates1 != 0
		;LogTrace("Update registered parameters set1=0x"+ConvertIDToHex(registered_updates1))
		UpdateRegistered1()
	endif
	if registered_updates2 != 0
		;LogTrace("Update registered parameters set2=0x"+ConvertIDToHex(registered_updates2))
		UpdateRegistered2()
	endif
EndFunction

Function UpdateRegistered1()
	int cur_registered = registered_updates1
	;LogTrace("Update registered parameters=0x"+ConvertIDToHex(cur_registered))
	if Math.LogicalAnd(cur_registered, 0x1) == 0x1
		SetChanceAngry()
	endif
	if Math.LogicalAnd(cur_registered, 0x2) == 0x2
		SetChanceAfraid()
	endif
	if Math.LogicalAnd(cur_registered, 0x4) == 0x4
		SetChanceTerrified()
	endif
	if Math.LogicalAnd(cur_registered, 0x8) == 0x8
		SetChanceScared()
	endif
	if Math.LogicalAnd(cur_registered, 0x10) == 0x10
		SetChanceAshamed()
	endif
	if Math.LogicalAnd(cur_registered, 0x20) == 0x20
		SetChanceSad()
	endif
	if Math.LogicalAnd(cur_registered, 0x40) == 0x40
		SetChanceShock()
	endif
	if Math.LogicalAnd(cur_registered, 0x80) == 0x80
		SetChanceBroken()
	endif
	if Math.LogicalAnd(cur_registered, 0x100) == 0x100
		SetChanceLoyal()
	endif
	if Math.LogicalAnd(cur_registered, 0x200) == 0x200
		SetChanceInlove()
	endif
	if Math.LogicalAnd(cur_registered, 0x400) == 0x400
		SetChanceJealous()
	endif
	if Math.LogicalAnd(cur_registered, 0x800) == 0x800
		SetChanceDepressed()
	endif
	if Math.LogicalAnd(cur_registered, 0x1000) == 0x1000
		SetChanceAngryForUnfairness()
	endif
	if Math.LogicalAnd(cur_registered, 0x2000) == 0x2000
		SetChanceAngryForInjustice()
	endif
	if Math.LogicalAnd(cur_registered, 0x4000) == 0x4000
		SetChanceSadForUnfairness()
	endif
	if Math.LogicalAnd(cur_registered, 0x8000) == 0x8000
		SetChanceSadForInjustice()
	endif
	if Math.LogicalAnd(cur_registered, 0x10000) == 0x10000
		SetChanceRecoverFromAngry()
	endif
	if Math.LogicalAnd(cur_registered, 0x20000) == 0x20000
		SetChanceRecoverFromAfraid()
	endif
	if Math.LogicalAnd(cur_registered, 0x40000) == 0x40000
		SetChanceRecoverFromAshamed()
	endif
	if Math.LogicalAnd(cur_registered, 0x80000) == 0x80000
		SetChanceRecoverFromSad()
	endif
	if Math.LogicalAnd(cur_registered, 0x100000) == 0x100000
		SetChanceRecoverFromShock()
	endif
	if Math.LogicalAnd(cur_registered, 0x200000) == 0x200000
		SetChanceRecoverFromBroken()
	endif
	if Math.LogicalAnd(cur_registered, 0x400000) == 0x400000
		SetChanceRecoverFromJealous()
	endif
	if Math.LogicalAnd(cur_registered, 0x800000) == 0x800000
		SetChanceRecoverFromDepressed()
	endif
	if Math.LogicalAnd(cur_registered, 0x1000000) == 0x1000000
		SetChanceRespectful()
	endif
	if Math.LogicalAnd(cur_registered, 0x2000000) == 0x2000000
		SetChanceFightForPlayer()
	endif
	if Math.LogicalAnd(cur_registered, 0x4000000) == 0x4000000
		SetChancePunishedMultiplier()
	endif
	if Math.LogicalAnd(cur_registered, 0x8000000) == 0x8000000
		SetChanceHappy()
	endif
	if Math.LogicalAnd(cur_registered, 0x10000000) == 0x10000000
		SetChanceInsecure()
	endif
	;LogTrace("After update1 0x"+DOM_Util.ConvertIDToHex(registered_updates1)+" "+DOM_Util.ConvertIDToHex(cur_registered))
	registered_updates1 = Math.LogicalXor(registered_updates1,cur_registered)
	;LogTrace("End update1 0x"+DOM_Util.ConvertIDToHex(registered_updates1))
EndFunction

Function UpdateRegistered2()
	int cur_registered = registered_updates2
	;LogTrace("Update registered parameters=0x"+ConvertIDToHex(cur_registered))
	if Math.LogicalAnd(cur_registered, 0x1) == 0x1
		SetChanceRecoverFromInsecure()
	endif
	if Math.LogicalAnd(cur_registered, 0x2) == 0x2
		SetChanceRunAway()
	endif
	if Math.LogicalAnd(cur_registered, 0x4) == 0x4
		SetChanceRunAwayGang()
	endif
	if Math.LogicalAnd(cur_registered, 0x8) == 0x8
		SetChanceProud()
	endif
	if Math.LogicalAnd(cur_registered, 0x10) == 0x10
		SetChanceCrushed()
	endif
	if Math.LogicalAnd(cur_registered, 0x20) == 0x20
		SetChanceDefiant()
	endif
	if Math.LogicalAnd(cur_registered, 0x40) == 0x40
		SetChanceCharmed()
	endif
	if Math.LogicalAnd(cur_registered, 0x80) == 0x80
		UpdateTrainingStatus()
	endif
	if Math.LogicalAnd(cur_registered, 0x100) == 0x100
		UpdatePersonalityIndex()
	endif
	;LogTrace("After update2 0x"+DOM_Util.ConvertIDToHex(registered_updates2)+" "+DOM_Util.ConvertIDToHex(cur_registered))
	registered_updates2 = Math.LogicalXor(registered_updates2,cur_registered)
	;LogTrace("End update2 0x"+DOM_Util.ConvertIDToHex(registered_updates2))
EndFunction

; ### Recover from mood

bool Function RecoverFrom()
	return true
EndFunction

bool Function RecoverFromSadByComfort()
	Float base_chance = __chance_recover_from_sad*0.5*__chance_recently_punished
	Float mod_chance = MOD_Hope
	Float chance = base_chance+mod_chance
	;LogTrace(""+name+" recover sad comfort="+chance+" = "+base_chance+" * "+mod_chance)
	;LogTrace(""+name+" recover sad comfort="+chance)
	if RandomFloat() < chance
		ChooseMoodChange()
		return true
	endif
	return false
EndFunction

bool Function RecoverFromShockByComfort()
	Float base_chance = __chance_recover_from_shock*0.5*__chance_recently_punished_inverted
	Float mod_chance = MOD_Hope
	Float chance = base_chance+mod_chance
	float rand = RandomFloat()
	;LogTrace("recover shock comfort="+chance)
	if rand < chance
		ChooseMoodChange()
		return true
	endif
	return false
EndFunction

; ### Events ###

bool on_update = false
Event OnUpdate()
	;LogTrace("--------------------- OnUpdate Name="+name+"  Init="+is_initializing+" Cleared="+before_clear_is_busy+" OnUpdate="+on_update+" Busy="+mood_is_busy)
	if before_clear_is_busy || is_initializing || actor_alias == None || actor_alias.is_initializing || akRef == None
		LogTrace("--------------------- OnUpdate INACTIVE Init="+is_initializing+" Cleared="+before_clear_is_busy+" OnUpdate="+on_update+" Busy="+mood_is_busy+" actor="+actor_alias+" akRef="+akRef)
		return
	endif
	if on_update || mood_is_busy
		;LogTrace("--------------------- OnUpdate FAILED OnUpdate="+on_update+" busy="+mood_is_busy+" confidence="+akRef.GetBaseActorValue("confidence")+" aggression="+akRef.GetBaseActorValue("aggression"))
		return
	endif
	on_update = true
	UpdateRegistered()
	HandleShouldHaveFought()
	HandlePunishmentOnUpdate()
	HandleAlcoholOnUpdate()
	HandlePromiseOnUpdate()
	HandleArousalOnUpdate()
	HandleWalkingOnUpdate()
	HandleMindTimers()
	OnMoodUpdate() ; choose idle
	on_update = false
EndEvent

bool on_update_gametime = false
Event OnUpdateGameTime()
	;LogTrace("+++++++++++++++++++++ OnUpdateGameTime Name="+name+" Cleared="+before_clear_is_busy+" OnUpdateGameTime="+on_update_gametime+" Busy="+mood_is_busy)
	if before_clear_is_busy || is_initializing || actor_alias == None || actor_alias.is_initializing || akRef == None
		LogTrace("+++++++++++++++++++++ OnUpdateGameTime INACTIVE Init="+is_initializing+" Cleared="+before_clear_is_busy+" OnUpdateGameTime="+on_update_gametime+" Busy="+mood_is_busy+" actor="+actor_alias+" akRef="+akRef)
		return
	endif
	if on_update_gametime || mood_is_busy
		;LogTrace("+++++++++++++++++++++ OnUpdateGameTime FAILED OnUpdateGameTime="+on_update_gametime+" busy="+mood_is_busy)
		return
	endif
	on_update_gametime = true
	OnMoodUpdateGameTime() ; update mood and decisions
	on_update_gametime = false
EndEvent

Event OnEndPunishment(Float severity)
	if !actor_alias.CanTalk()
		return
	endif
	if !WillTalkUnderPain()
		return
	endif
	ChooseTopic()
EndEvent

Event OnToldOff(int ireason)
	ChooseMoodSpontaneous(0.1)
	if !actor_alias.canIdle
		return
	endif 
	; Idle should be adapted to reason
	if RandomFloat() < MOD_Authority
		actor_alias.Anim_LookDown()
		return
	elseif RandomFloat() > MOD_Discipline
		if RandomFloat() < MOD_Impatience && RandomFloat()*100.0 > respect_training
			actor_alias.Anim_AggressiveGesture()
			was_respectful = false
			SetNextPunishmentReasonSilent(13) ; "being disrespectful"
		else
			actor_alias.Anim_CrossArms()
		endif
		return
	elseif ireason == 25 && RandomFloat() < MOD_Fearfulness ;  "running away"
		actor_alias.Anim_Cower()
		SetNextPunishmentReasonSilent(3) ; "cowering"
		return
	elseif (ireason == 19 || ireason == 20) && RandomFloat() < MOD_Naivety ; "didnt masturbate" || "refusing to masturbate"
		if TryCoverSelf()
			return
		endif
	else
		ChooseIdle()
		return
	endif
	ChooseDrunkIdle()
EndEvent

; ### Counters and flags ###

bool __is_freed_slave = false
bool Property is_freed_slave Hidden
	bool Function get()
		return __is_freed_slave
	EndFunction
	Function set(bool value)
		__is_freed_slave = value
		RegisterForUpdateChanceAngry()
		RegisterForUpdateChanceDefiant()
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceHappy()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInLove()
		UpdateRegistered()
	EndFunction
EndProperty
bool __is_slave = true
bool Property is_slave Hidden
	bool Function get()
		return __is_slave
	EndFunction
	Function set(bool value)
		__is_slave = value
	EndFunction
EndProperty
bool __is_player_actor = false
bool Property is_player_actor Hidden
	bool Function get()
		return __is_player_actor
	EndFunction
	Function set(bool value)
		__is_player_actor = value
	EndFunction
EndProperty

Function SetSlaveOwner(Actor akOwner)
	actor_owner = akOwner
	if actor_owner == PlayerRef
		actor_owner_title = DOM01.DOMPlayerAlias.GetPlayerTitle()
		actor_owner_sex = DOM01.DOMPlayerAlias.GetPlayerSex()
	elseif is_slave
		if actor_owner != None
			if actor_owner.GetLeveledActorBase().GetSex() == 0
				actor_owner_title = "Master"
				actor_owner_sex = 0
			else
				actor_owner_title = "Mistress"
				actor_owner_sex = 1
			endif
		else
			actor_owner_title = "For sell"
			actor_owner_sex = -1
		endif
	else
		actor_owner_title = ""
		actor_owner_sex = -1
	endif
EndFunction

Actor Property actor_owner = None Auto Hidden
string Property actor_owner_title = "" Auto Hidden
int __actor_owner_sex = -1
int Property actor_owner_sex Hidden
	int Function get()
		return __actor_owner_sex
	EndFunction
	Function set(int value)
		__actor_owner_sex = value
		akRef.SetFactionRank(DOM01.DOMActorOwnerGender,value)
	EndFunction
EndProperty
bool __is_player_slave = true
bool Property is_player_slave Hidden
	bool Function get()
		return __is_player_slave
	EndFunction
	Function set(bool value)
		__is_player_slave = value
	EndFunction
EndProperty

bool __is_love_interest = true
bool Property is_love_interest Hidden
	bool Function get()
		return __is_love_interest
	EndFunction
	Function set(bool value)
		__is_love_interest = value
		SetBoolFaction(akRef, DOM01.DOMIsLoveInterest, __is_love_interest)
		; Update dependencies
		RegisterForUpdateChanceInLove()
	EndFunction
EndProperty

bool Function IsNotRespectful(float mod)
	; smaller mod means more chance to not be respectful
	;if IsInLove()
	;	return false
	;endif
	was_respectful = true
	if !is_slave
		return false ; non slaves will be respectful by default for now
	endif
	if RandomFloat() < __chance_respectful*mod
		;LogTrace("Is respectful chance is high enough")
		return false
	endif
	if RandomFloat()*100.0 < respect_training
		;LogTrace("Is respectful training is high enough")
		return false
	endif
	if should_be_respectful
		if WasWarned(13)
			if RandomFloat() < __chance_respectful*mod ; "being disrespectful"
				;LogTrace("Is respectful because was warned")
				SendNotificationAbuse(name+" hesitates, but cools down remembering your warning")
				return false
			endif
		elseif WasPunishedFor(13)
			if RandomFloat() < __chance_respectful*mod ; "being disrespectful"
				;LogTrace("Is respectful because of last punishment")
				SendNotificationAbuse(name+" hesitates, but cools down remembering the punishment")
				return false
			endif
		endif
		was_respectful = false
		SetNextPunishmentReasonSilent(13) ; "being disrespectful"
		actor_alias.Anim_AggressiveGesture()
		;LogTrace("IsNotRespectful() not respectful")
	endif
	return true
EndFunction

bool Function IsNotRespectfullyWriting(float mod)
	; smaller mod means more chance to not be respectful
	;if IsInLove()
	;	return false
	;endif
	if !is_slave
		return false ; non slaves will be respectful by default for now
	endif
	if RandomFloat() < __chance_respectful*mod
		;LogTrace("Is respectful chance is high enough")
		return false
	endif
	if RandomFloat()*100.0 < respect_training
		;LogTrace("Is respectful training is high enough")
		return false
	endif
	if should_be_respectful
		if WasWarned(13)
			if RandomFloat() < __chance_respectful*mod ; "being disrespectful"
				;LogTrace("Is respectful because was warned")
				SendNotificationAbuse(name+" mumbles something but keeps "+actorPossessive+" writings respectful")
				return false
			endif
		elseif WasPunishedFor(13)
			if RandomFloat() < __chance_respectful*mod ; "being disrespectful"
				;LogTrace("Is respectful because of last punishment")
				SendNotificationAbuse(name+" mumbles but cools down remembering the punishment")
				return false
			endif
		endif
		;SendNotificationAbuse(name+" is not very respectful in "+actorPossessive+" writings")
		SetNextPunishmentReasonSilent(13) ; "being disrespectful"
		actor_alias.Anim_AggressiveGesture()
		;LogTrace("IsNotRespectful() not respectful")
	endif
	return true
EndFunction

bool Function IsWalkingOnFour(float mod)
	; smaller mod means more chance to not
	if !is_slave
		return true
	endif
	if IsObedient()
		SetObedientTimer(10)
		return true
	endif
	
	float x = humiliation+submission
	if RandomFloat()*200.0 < x*mod
		SetObedientTimer(10)
		return true
	endif
	
	if RandomFloat()*10.0 < (MOD_Discipline + MOD_Naivety)
		SetObedientTimer(10)
		return true
	endif

	if WasWarned(32)
		if RandomFloat() < __chance_respectful*mod
			;LogTrace("Is walking like a dog because was warned")
			SendNotificationAbuse(name+" wants to stand up, but stays down remembering your warning")
			return true
		endif
	elseif WillObeyBecauseAbuse(32, 1.2)
		if RandomFloat() < __chance_respectful*mod 
			;LogTrace("Is walking like a dog because of last punishment or any other abuse")
			SendNotificationAbuse(name+" wants to stand up, but stays down remembering the punishment")
			SetObedientTimer(10)
			return true
		endif
	endif
	
	SendNotificationAbuse(name+" doesn't feel like walking on four")
	SetNextPunishmentReasonSilent(32) ; "not walking on four"
	LogTrace("IsWalkingOnFour Anim_IdleReset")
	actor_alias.Anim_IdleReset()
	return false
EndFunction

Function HandleWalkingOnUpdate()
	if !__should_walk_on_four
		return
	endif
	if !__is_walking_on_four
		return
	endif
	is_walking_on_four = IsWalkingOnFour(2.0)
EndFunction

; ### Arousal & orgasm system

float __arousal_factor = 0.0
Float Property arousal_factor Hidden ; is getting more and more aroused
	float Function get()
		return __arousal_factor
	EndFunction
	Function set(float value)
		DOM01.DOMSexlab.HandleArousal(akRef,__arousal_factor,value,actorSex)
		__arousal_factor = value
	EndFunction
EndProperty

Int __is_aroused_for = 0 ; has reached the arousal plateau, orgasm is possible
Int Property is_aroused_for Hidden
	Int Function get()
		return __is_aroused_for
	EndFunction
	Function set(Int value)
		if __is_aroused_for != 0 && value == 0
			actor_alias.TryRemoveBlush()
		elseif __is_aroused_for == 0 && value > 0
			actor_alias.TryApplyBlush()
		endif
		__is_aroused_for = value
	EndFunction
EndProperty

Int __is_enraptured_for = 0 ; is ecstatic
Int Property is_enraptured_for Hidden
	Int Function get()
		return __is_enraptured_for
	EndFunction
	Function set(Int value)
		if __is_enraptured_for != 0 && value == 0
			actor_alias.TryRemoveDrool()
		elseif __is_enraptured_for == 0 && value > 0
			actor_alias.TryApplyDrool()
		endif
		__is_enraptured_for = value
	EndFunction
EndProperty

bool Function IsAroused()
	if __is_aroused_for > 0
		return true
	endif
	return false
EndFunction

Function HandleArousalOnUpdate()
	;LogTrace("HandleArousalOnUpdate arousal="+arousal_factor+" aroused_for="+__is_aroused_for+" enraptured="+__is_enraptured_for)	
	;if !is_love_interest
	;	arousal_factor = 0.0
	;	return
	;endif
	
	if arousal_factor > 0.0 ; Update is every 1 second
		arousal_factor -= 0.002*(100.0-FACET_Sensuality) ; 15 minutes from 100 to 0
		if arousal_factor < 0.0
			arousal_factor = 0.0
		else
			IsArousedSpontaneously(FACET_Sensuality/100.0)
		endif
	endif

	if is_aroused_for > 0
		is_aroused_for -= 1
		if arousal_factor > 200.0  && RandomFloat() < FACET_Sensuality*0.5
			if actor_alias.is_behaviour_masturbate && (((actorSex%2) == 1) || __is_enraptured_for == 0)
				;LogTrace("HandleArousalOnUpdate try orgasm arousal="+arousal_factor+" aroused_for="+__is_aroused_for+" enraptured="+__is_enraptured_for)	
				; chance to get orgasm
				if IsOrgasmingAfterArousal(MOD_Daring*0.1)
					if actor_alias.is_behaviour_masturbate
						actor_alias.SendExternalEventSS("Orgasm","masturbate")
						DOM01.DOM04.NotifyOrgasm(actor_alias,"masturbate",should_be_noorgasm,was_allowed_toorgasm,false)
					else
						actor_alias.SendExternalEventSS("Orgasm","arousal")
						DOM01.DOM04.NotifyOrgasm(actor_alias,"arousal",should_be_noorgasm,was_allowed_toorgasm,false)
					endif
				endif
			endif
		endif
	endif
	if __is_enraptured_for > 0
		is_enraptured_for -= 1
	endif
EndFunction

Function IncreaseArousal(float amount, float reason_modifier)
	float mod  = (FACET_Sensuality/200.0 + 0.5 + reason_modifier/10.0)
	float trainer_mod
	if sex_active
		Actor akAbuser = actor_alias.GetCurrentSexTrainer()
		if sex_is_non_consensual
			trainer_mod = DOM01.GetPredatorModifier(akAbuser)
		else
			trainer_mod = DOM01.GetDeceiverModifier(akAbuser)
		endif
	else
		trainer_mod = DOM01.GetDepraverModifier(actor_alias.GetCurrentTrainer())
	endif
	float value = amount * mod * DOM01.train_speed_arousal * trainer_mod
	if (((actorSex%2) == 0) && __is_enraptured_for > 0)
		arousal_factor += value/10.0
		return
	endif
	arousal_factor += value
	;LogTrace("arousal_factor="+arousal_factor+" value="+value+" amount="+amount+" mod="+mod+" trainer="+trainer_mod)
EndFunction

Function IncreaseArousalMagic(float amount) ; magical arousal (lust potion)
	if amount > 0.0
		IncreaseArousal(amount,MOD_Daring)
		is_aroused_for = (FACET_Sensuality+100.0-FACET_Smartness) as int
		AddNextPraiseReason(19) ; "being a good horny pet"
	else
		if IsOrgasmingAfterArousal(MOD_Daring*0.5)
			actor_alias.SendExternalEventSS("Orgasm","magic")
			DOM01.DOM04.NotifyOrgasm(actor_alias,"magic",should_be_noorgasm,was_allowed_toorgasm,false)
		endif
		arousal_factor = arousal_factor/100.0
		is_aroused_for = 0
	endif

	HEXACO_Honesty       = HEXACO_Honesty+amount*DOM_Util.RandG1() ; Unlawful/Honest Hexaco: Honesty 
	HEXACO_eXtraversion  = HEXACO_eXtraversion-amount*DOM_Util.RandG1()*2.0 ; Shy/Lively      Hexaco: eXtraversion 
	HEXACO_Agreeableness = HEXACO_Agreeableness+amount*DOM_Util.RandG1()*2.0 ; Grumpy/Gentle   Hexaco: Agreeableness
	HEXACO_Openness      = HEXACO_Openness-amount*DOM_Util.RandG1()*2.0 ; Shallow/Open    Hexaco: Openness to Experience
	FACET_Sensuality     = FACET_Sensuality+amount*DOM_Util.RandG1()*3.0 ; Frigid/Sensual, sexual sensitivity
	FACET_Toughness      = FACET_Toughness-amount*DOM_Util.RandG1()  ; Delicate/Tough, physical sensitivity
	FACET_Submissivity   = FACET_Submissivity+amount*DOM_Util.RandG1()*3.0 ; DOM/Sub         perversion orientation

	; Compute modifiers & update
	; ResetModifiers() ; this is done automatically
EndFunction

Function IncreasePainForced(float amount)
	if amount > 0.0
		IncreaseArousal(amount/10.0,MOD_Discipline)
	endif

	HEXACO_Honesty      = HEXACO_Honesty+amount*RandG1() ; Unlawful/Honest Hexaco: Honesty 
	HEXACO_Emotionality = HEXACO_Emotionality+amount*RandG1()*2.0 ; Anxious/Calm   Hexaco: Emotionality 
	FACET_Boldness      = FACET_Boldness-amount*RandG1()   ; Needy, clingy/Bold,  independant, social sensitivity
	FACET_Wilfulness    = FACET_Wilfulness-amount*RandG1()*3.0  ; Weak minded/Wilful, sensitivity to mind attacks
	FACET_Sensuality    = FACET_Sensuality+amount*RandG1()*2.0 ; Frigid/Sensual, sexual sensitivity
	FACET_Toughness     = FACET_Toughness-amount*RandG1()*3.0; Delicate/Tough, physical sensitivity
	FACET_Submissivity  = FACET_Submissivity+amount*RandG1()*2.0; DOM/Sub         perversion orientation

	; Compute modifiers & update
	; ResetModifiers()  ; this is done automatically
EndFunction

Function IncreasePersonaForced(float amount)
	HEXACO_Honesty           = HEXACO_Honesty+amount*RandG1()  ; Sly/Honest  Hexaco: Honesty-Humility  
	HEXACO_Emotionality      = HEXACO_Emotionality+amount*RandG1() ; Anxious/Calm   Hexaco: Emotionality 
	HEXACO_eXtraversion      = HEXACO_eXtraversion+amount*RandG1() ; Shy/Lively     Hexaco: eXtraversion 
	HEXACO_Agreeableness     = HEXACO_Agreeableness+amount*RandG1() ; Grumpy/Gentle  Hexaco: Agreeableness
	HEXACO_Conscientiousness = HEXACO_Conscientiousness+amount*RandG1() ; Lazy/Thorough  Hexaco: Conscientiousness 
	HEXACO_Openness          = HEXACO_Openness+amount*RandG1() ; Shallow/Open   Hexaco: Openness to Experience

	FACET_Boldness           = FACET_Boldness+amount*RandG1() ; Needy, clingy/Bold,  independant, social sensitivity
	FACET_Wilfulness         = FACET_Wilfulness+amount*RandG1() ; Weak minded/Wilful, sensitivity to mind attacks
	FACET_Smartness          = FACET_Smartness+amount*RandG1() ; Stupid/Smart   strength of the mind
	FACET_Sensuality         = FACET_Sensuality+amount*RandG1() ; Frigid/Sensual, sexual sensitivity
	FACET_Toughness          = FACET_Toughness+amount*RandG1() ; Delicate/Tough, physical sensitivity
	FACET_Submissivity       = FACET_Submissivity+amount*RandG1() ; DOM/Sub, perversion direction

	; Compute modifiers & update
	; ResetModifiers() ; this is done automatically
EndFunction

Function EraseMemory()
	fear_training    = 0.0
	respect_training = 0.0
	anger_training   = 0.0
	submission       = 0.0
	humiliation      = 0.0
	resignation      = 0.0
	
	pose_training   = 0.0
	combat_training = 0.0
	house_training  = 0.0
	work_training   = 0.0
	
	skill_enforcer  = 0.0
	skill_predator  = 0.0
	skill_depraver  = 0.0
	skill_persuader = 0.0
	skill_slaver    = 0.0
	skill_deceiver  = 0.0

	love_desire = 0.0
	loyal_worship = 0.0
	love_fascination = 0.0
	loyal_absolution = 0.0
	loyal_devotion = 0.0
	love_admiration = 0.0

	timer_for_broken        = 0.0
	number_of_brainwashed   = 0
	number_of_broken        = 0
	number_of_comfort       = 0
	number_of_flatter       = 0
	number_of_insult        = 0
	number_of_drug          = 0
	number_of_pain          = 0
	number_of_bondage       = 0
	number_of_praise        = 0
	number_of_promise       = 0
	number_of_shame         = 0
	number_of_shock         = 0
	number_of_threat        = 0
	number_of_toldoff       = 0
	number_of_chat_feelings    = 0
	number_of_chat_personality = 0
	number_of_trainee          = 0
	number_of_trainer          = 0
	number_of_recruitedslavers = 0
	number_of_whoredslaves     = 0
	number_of_ransomedslaves   = 0
	number_of_capturedslaves   = 0
	number_of_soldslaves       = 0
	number_of_brokenslaves     = 0
	number_of_player_fling     = 0
	number_of_player_chat      = 0
EndFunction

int[] Function SaveKnownKinks()
	int[] saved_kinks_slot = new int[8]
	int i = 0
	int n = saved_kinks_slot.length
	int m = known_kinks_slot.length
	while i < n && i < m
		saved_kinks_slot[i] = known_kinks_slot[i]
		i += 1
	endwhile
	return saved_kinks_slot
EndFunction

Function RestoreKnownKinks(int [] saved_kinks_slot)
	int i = 0
	int n = saved_kinks_slot.length
	int m = hidden_kinks_slot.length
	while i < n
		;LogTrace("RestoreKnownKinks saved kink="+saved_kinks_slot[i])
		if saved_kinks_slot[i] > 0
			int j = 0
			while j < m
				;LogTrace("RestoreKnownKinks new kink="+hidden_kinks_slot[j])
				if hidden_kinks_slot[j] == saved_kinks_slot[i]
					LogTrace("RestoreKnownKinks known kink="+hidden_kinks_slot[j])
					AddKnownKink(hidden_kinks_slot[j])
				endif
				j += 1
			endwhile
		endif
		i += 1
	endwhile
	int kmax = known_kinks_slot.length
	int k = DOM01.DOMGenerator.GetKnownKinksNumber(akRef,actorSex,kmax)
	LogTrace("RestoreKnownKinks nkinks="+k)
	if k <= 0
		return
	endif
	SetKnownKinksFromJSON(k)
EndFunction

Function SetKnownKinksFromJSON(int nkinksJSON)
	int kmax = known_kinks_slot.length
	if nkinksJSON <= 0
		nkinksJSON = DOM01.DOMGenerator.GetKnownKinksNumber(akRef,actorSex,kmax)
	endif
	if nkinksJSON <= 0
		return
	endif

	int i = 0
	while i < kmax 
		int kink = DOM01.DOMGenerator.GetKnownKink(akRef,actorSex,i)
		if kink > 0
			LogTrace("SetKnownKinksFromJSON known kink="+kink)
			AddKnownKink(kink)
		endif
		i += 1
	endwhile
EndFunction

Function RestoreHiddenKinks()
	int kmax = hidden_kinks_slot.length
	int k = DOM01.DOMGenerator.GetHiddenKinksNumber(akRef,actorSex,kmax)
	LogTrace("RestoreHiddenKinks nkinks="+k)
	if k <= 0
		return
	endif
	int[] saved_kinks_slot = SaveKnownKinks()
	LogTrace("RestoreHiddenKinks n saved kinks="+saved_kinks_slot.length)
	ClearKinks()
	SetKinks(k)
	RestoreKnownKinks(saved_kinks_slot)
EndFunction

Function RecoverVirginity()
	; Zero virginity
	; SexLab stats
	DOM01.DOMSexlab.ClearStats(akRef)
	; Virgin status
	virgin_status_vaginal = 0 
	virgin_status_anal    = 0
	virgin_status_oral    = 0 
	virgin_status_same    = 0
	virgin_status_gang    = 0 

	if virgin_status_vaginal == 0 && virgin_status_anal == 0 && virgin_status_oral == 0 && virgin_status_same == 0
		; never had sex
		number_of_sex    = 0
		number_of_sexformoney    = 0
		number_of_sexwithothers  = 0
		number_of_rape   = 0
		number_of_orgasm = 0
		virgin_status_gang = 0
	elseif vaginal_training == 0.0 && anal_training == 0.0 && oral_training == 0.0
		; was never trained
		number_of_sex    = 0
		number_of_sexformoney    = 0
		number_of_sexwithothers  = 0
		number_of_rape   = 0
		number_of_orgasm = 0
	endif
	
	IncreaseArousal(50.0,MOD_Daring)
	; update mind change mood parameters now
	UpdateRegistered()
EndFunction

Function RestoreVirginity()
	; Clear factions to force read from file or generate
	akRef.RemoveFromFaction(DOM01.DOMVirginOral)
	akRef.RemoveFromFaction(DOM01.DOMVirginVaginal)
	akRef.RemoveFromFaction(DOM01.DOMVirginAnal)
	akRef.RemoveFromFaction(DOM01.DOMVirginSame)
	akRef.RemoveFromFaction(DOM01.DOMVirginGangbang)

	int[] vstatus = DOM01.DOMGenerator.GetVirginStatus(akRef)
	SetVirginStatus(vstatus)
	
	if virgin_status_vaginal == 0
		vaginal_training = 0.0
	endif
	if virgin_status_anal == 0
		anal_training    = 0.0
	endif
	if virgin_status_oral == 0
		oral_training    = 0.0
	endif

	if virgin_status_vaginal == 0 && virgin_status_anal == 0 && virgin_status_oral == 0 && virgin_status_same == 0
		; never had sex
		number_of_sex    = 0
		number_of_sexformoney    = 0
		number_of_sexwithothers  = 0
		number_of_rape   = 0
		number_of_orgasm = 0
		virgin_status_gang = 0
	elseif vaginal_training == 0.0 && anal_training == 0.0 && oral_training == 0.0
		; was never trained
		number_of_sex    = 0
		number_of_sexformoney    = 0
		number_of_sexwithothers  = 0
		number_of_rape   = 0
		number_of_orgasm = 0
	endif
	
	IncreaseArousal(50.0,MOD_Daring)
	; update mind change mood parameters now
	UpdateRegistered()
EndFunction

Function RestorePersonality()
	;LogTrace("RestorePersonality")
	; Reset base values
	float[] TraitsArray  = DOM01.DOMGenerator.ReadBaseTraits(akRef)	
	SetBaseTraits(TraitsArray)
	
	; Personnality traits as described by the HEXACO model
	TraitsArray = DOM01.DOMGenerator.GetTraitsReadOrGenerated(akRef)	
	SetDefaultTraits(TraitsArray)

	; update mind change mood parameters now
	UpdateRegistered()
EndFunction

; ### Events & sex

Function RegisterModEvents()
	; Just make sure to not create duplicates
	UnregisterModEvents()

	; Create a hook when actor is added to a SexLab animation
	RegisterForSexEvents()
EndFunction

Function UnregisterModEvents()
	UnregisterForSexEvents()
EndFunction

Function RegisterForSexEvents()
	; Create a hook when actor is added to a SexLab animation
	string formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	DOM01.DOMSexlab.TrackActor(akRef, "DOM" + formid)
	RegisterForModEvent("DOM" + formid + "_Added", "handleSexEvent")
EndFunction

Function ResetActorRef()
	akRef = actor_alias.akRef
	if akRef == None
		akRef = GetActorRef()
	endif
EndFunction

Function UnregisterForSexEvents()
	if akRef == none
		ResetActorRef()
		if akRef == None
			LogInfo("ERROR: UnregisterForSexEvents akRef=None")
			return
		endif
	endif
	string formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	DOM01.DOMSexlab.UnTrackActor(akRef, "DOM" + formid)
	UnregisterForModEvent("DOM" + formid + "_Added")
EndFunction

bool Property hadOralSex = false Auto Hidden
bool Property hadAnalSex = false Auto Hidden
bool Property hadVaginalSex = false Auto Hidden
bool Property sex_is_non_consensual = true Auto Hidden
bool Property sex_is_dominant = false Auto Hidden
bool Property sex_is_threesome = false Auto Hidden
bool Property sex_is_interracial = false Auto Hidden
bool Property sex_with_player = true Auto Hidden
bool Property sex_with_animal = false Auto Hidden
bool Property sex_with_undead = false Auto Hidden
bool Property sex_with_creature = false Auto Hidden
bool Property sex_with_animunculi = false Auto Hidden
bool Property sex_with_taboo = false Auto Hidden
bool Property sex_with_inlaw = false Auto Hidden
bool Property sex_with_relative = false Auto Hidden
bool sex_active = false

Event handleSexEvent(Form TrackedForm, int tid)
	Actor akTarget = TrackedForm as Actor
	if  akRef == None && akTarget != None
		ResetActorRef()
		if akRef == None
			LogTrace("HandleSexEvent: ERROR Wrong actor "+name+" ref=None Form="+akTarget.GetDisplayName())
			UnregisterForSexEvents()
			return
		endif
	endif
	
	sex_active = true
	sslThreadController controller = DOM01.DOMSexlab.GetController(tid)

	sslBaseAnimation anim = controller.Animation
	While anim == None
		wait(1.0)
		anim = controller.Animation
	endwhile
	LogTrace("HandleSexEvent: "+name+" anim="+anim+" actor started="+actor_alias.was_sexlab_started)

	if !actor_alias.was_sexlab_started
		handleOnSexStart(controller)
	endif
	handleSexStart(controller.isVictim(akRef), anim.GetRawTags())

	; Create a hook for the orgasm of this SexLab animation
	string formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	string str_hook1 = "DOM" + formid+"ORGASM"
	controller.SetHook(str_hook1)
	RegisterForModEvent("HookOrgasmStart_"+str_hook1, "handleSexOrgasmEvent")
	;RegisterForModEvent("SexLabOrgasmSeparate_"+str_hook1, "handleSeparateOrgasmEvent")
	RegisterForModEvent("SexLabOrgasmSeparate","handleSeparateOrgasmEvent")
	;LogTrace("setting hook for orgasm: "+str_hook1)
	
	; Create a hook for the end of this SexLab animation
	string str_hook2 = "DOM" + formid+"END"
	controller.SetHook(str_hook2)
	RegisterForModEvent("HookAnimationEnd_"+str_hook2, "handleSexEndEvent")
	;LogTrace("setting hook for end:"+str_hook2)
EndEvent

Function handleOnSexStart(sslThreadController controller)
	LogTrace("handleSexOnStart Scene was not started through DOM. Calling OnSexStart for actor.")
	bool isVictim = controller.IsVictim(akRef)
	bool hasPlayer = controller.HasPlayer
	bool hasSexAlone = false
	Actor[] Positions = controller.Positions
	if Positions.length == 0 ; use victims list
		Positions = controller.victims
	endif
	DOM_Actor akAnotherActor = None
	Actor akOther = None
	if Positions.length > 0 && Positions[0] != akRef
		akOther = Positions[0]
		akAnotherActor = DOM01.GetActor(akOther)
	elseif Positions.length > 1 && Positions[1] != akRef
		akOther = Positions[1]
		akAnotherActor = DOM01.GetActor(akOther)
	elseif Positions.length <= 1 ; masturbation
		hasSexAlone = true
	endif
	if hasSexAlone
		actor_alias.OnSexStartAlone()
	elseif !hasPlayer
		if isVictim
			actor_alias.OnSexStartNPC(akOther,hasPlayer,true)
		else
			actor_alias.OnSexStartNPC(akOther,hasPlayer,false)
		endif
	elseif isVictim
		actor_alias.OnSexStart(akAnotherActor,hasPlayer,true)
	else
		actor_alias.OnSexStart(akAnotherActor,hasPlayer,false)
	endif
	int nactors = Positions.length
	int i = 0
	while i < nactors
		Actor akAnother = Positions[i]
		if akAnother != akOther
			akAnotherActor = DOM01.GetActor(akAnother)
			if akAnotherActor != None
				actor_alias.SetSexPartner(akAnotherActor)
			endif
		endif
		i += 1
	endwhile
	LogTrace("handleSexOnStart should_be_naked="+should_be_naked+" should_wear_armor="+should_wear_armor+" should_hold_weapons="+should_hold_weapons)
	__was_should_be_naked = __should_be_naked
	__was_should_hold_weapons = __should_hold_weapons
	__was_should_wear_armor = __should_wear_armor
	if __should_hold_weapons
		should_hold_weapons = false
	endif
	if __should_wear_armor
		should_wear_armor = false
	endif
	if !DOM01.DOMSexlab.undressBeforeSex
		return
	endif
	should_be_naked = true
EndFunction

Function handleSexStart(bool isVictim, string[] anim)
	sex_active = true
	
	if !anim
		anim = GetSexTags()
	endif
	float trainer_mod
	if sex_is_non_consensual
		;PrintTrainingBefore("rape",1.0,"sex")
		if !actor_alias.has_sex_alone
			trainer_mod = DOM01.GetPredatorModifier(actor_alias.GetCurrentSexTrainer())
		else
			trainer_mod = 0.25
		endif
	else
		;PrintTrainingBefore("sex",1.0,"sex")
		if !actor_alias.has_sex_alone
			trainer_mod = DOM01.GetPredatorModifier(actor_alias.GetCurrentSexTrainer())
		else
			trainer_mod = 0.25
		endif
	endif

	; Maintain arousal
	IncreaseArousal(20.0,MOD_Daring)
	IsArousedAfterSex(MOD_Daring)
	
	had_separate_orgasm = false
	had_handle_orgasm = false
	had_slso = false
	
	float trainCount = 0.0
	hadAnalSex = false
	hadOralSex = false
	hadVaginalSex = false		
	
	if HasTag(anim,"Anal") ; || HasTag(anim,"analsex")
		trainCount += 1.0
		hadAnalSex = true
	endif
	if HasTag(anim,"Oral") ; || HasTag(anim,"oralsex")
		trainCount += 1.0
		hadOralSex = true
	endif
	if HasTag(anim,"Vaginal") ; || HasTag(anim,"vaginalsex")
		trainCount += 1.0
		hadVaginalSex = true
	endif
	;LogTrace("HandleSexStart: "+name+" anim tags="+anim)
	;LogTrace("HandleSexStart: "+name+" o/v/a="+hadOralSex+" "+hadVaginalSex+" "+hadAnalSex)
	float multiplier = trainer_mod*getSexMultiplier(hadOralSex, hadVaginalSex, hadAnalSex)*DOM01.train_speed_sex/100.0

	if is_aroused_for > 0 || __is_enraptured_for > 0 
		multiplier = 2.0*multiplier
	endif
	
	if isVictim
		multiplier = 2.0*multiplier
	endif

	if !actor_alias.has_sex_alone
		if virgin_status_oral == 0 && hadOralSex
			if actor_alias.IsSceneReallyInMouth()
				virgin_status_oral = 1
				multiplier = 1.5*multiplier
				IncreaseArousal(20.0,MOD_Oral)
				IsArousedAfterSex(MOD_Oral)
			else
				multiplier = 1.2*multiplier
				IncreaseArousal(10.0,MOD_Oral)
				IsArousedAfterSex(MOD_Oral)
			endif
		endif	
		if virgin_status_vaginal == 0 && hadVaginalSex
			if actor_alias.IsSceneReallyPenetration()
				virgin_status_vaginal = 1
				multiplier = 1.5*multiplier
				IncreaseArousal(20.0,MOD_Vaginal)
				IsArousedAfterSex(MOD_Vaginal)
			else
				multiplier = 1.2*multiplier
				IncreaseArousal(10.0,MOD_Vaginal)
				IsArousedAfterSex(MOD_Vaginal)
			endif
		endif	
		if virgin_status_anal == 0 && hadAnalSex
			if actor_alias.IsSceneReallyPenetration()
				virgin_status_anal = 1
				multiplier = 1.5*multiplier
				IncreaseArousal(20.0,MOD_Anal)
				IsArousedAfterSex(MOD_Anal)
			else
				multiplier = 1.2*multiplier
				IncreaseArousal(10.0,MOD_Anal)
				IsArousedAfterSex(MOD_Anal)
			endif
		endif	
		if virgin_status_gang == 0 && sex_is_threesome
			virgin_status_gang = 1
			multiplier = 1.5*multiplier
			IncreaseArousal(20.0,MOD_Creativity)
			IsArousedAfterSex(MOD_Creativity)
		endif	
		if HasTag(anim,"Lesbian") || HasTag(anim,"Gay")
			if actor_alias.IsSceneReallySameSex()
				if virgin_status_same == 0
					virgin_status_same = 1
					multiplier = 1.5*multiplier
					IncreaseArousal(20.0,MOD_Daring)
					IsArousedAfterSex(MOD_Daring)
				else
					multiplier = 1.2*multiplier
					IncreaseArousal(10.0,MOD_Daring)
					IsArousedAfterSex(MOD_Daring)
				endif
			endif
		endif
	endif

	trainAfterSex(multiplier,trainCount) ; train sextoys sex training and submission
	
	if actor_alias.has_sex_with_player
		number_of_sex += 1
	elseif !actor_alias.has_sex_alone
		number_of_sexwithothers += 1
	else
		number_of_shame += 1
	endif
	if actor_alias.has_sex_for_money
		number_of_sexformoney += 1
	endif
		
	if akRef.GetFactionRank(DOM01.DOMActionTraining) == 3
		;LogTrace("HandleSexStart: Sex trainer "+ GetMoodNameThirdPerson()+name)
		SetNextPraiseReasonSilent(51) ; "being a good sex trainer"
	elseif actor_alias.has_sex_with_player
		;LogTrace("HandleSexStart: Sexing "+ GetMoodNameThirdPerson()+name)
		SetNextPraiseReasonSilent(21) ; "being a good fucktoy"
	elseif actor_alias.has_sex_alone
		SetNextPraiseReasonSilent(19) ; "being a good horny pet"
	elseif actor_alias.has_sex_for_money
		;LogTrace("HandleSexStart: Sexing "+ GetMoodNameThirdPerson()+name)
		SetNextPraiseReasonSilent(53) ; "being a good whore"
	elseif actor_alias.GetSexTrainer() != None ; sex with trainer
		;LogTrace("HandleSexStart: Sexing "+ GetMoodNameThirdPerson()+name)
		SetNextPraiseReasonSilent(21) ; "being a good fucktoy"
	else ; sex with NPC
		;LogTrace("HandleSexStart: Sexing "+ GetMoodNameThirdPerson()+name)
		SetNextPraiseReasonSilent(58) ; "being a good sex pet"
	endif
EndFunction

bool had_orgasm = false
bool had_separate_orgasm = false
bool had_handle_orgasm = false
bool had_slso = false
Event handleSeparateOrgasmEvent(Form ActorRef, Int thisThread)
	had_slso = true ; Using SLSO
	if ActorRef != akRef
		if ActorRef == PlayerRef
			;LogTrace("handleSeparateOrgasmEvent: "+name+" squirms under your grasp as your orgasm submerges you")
			SendNotification(name+" squirms under your grasp as your orgasm submerges you")
			IncreaseArousal(20.0,MOD_Naivety)
		endif
		return
	endif
	sslThreadController controller = DOM01.DOMSexlab.GetController(thisThread)
	bool hasPlayer = controller.HasPlayer
	if hasPlayer == punishing_trainee_or_trainer
		hasPlayer = !punishing_trainee_or_trainer
	endif
	had_separate_orgasm = true
	handleSexOrgasmEvent(thisThread, hasPlayer)
EndEvent

Event handleSexOrgasmEvent(int tid, bool HasPlayer)
	handleSexOrgasm(HasPlayer)

	string formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	UnregisterForModEvent("HookOrgasmStart_"+"DOM" + formid +"ORGASM")
	;UnregisterForModEvent("SexLabOrgasmSeparate_"+"DOM" + formid +"ORGASM")
	UnregisterForModEvent("SexLabOrgasmSeparate")
EndEvent

Function handleSexOrgasm(bool HasPlayer)
	if hasPlayer && !had_slso ; 
		had_slso = true
		SendNotification(name+" squirms under your grasp as your orgasm submerges you")
		IncreaseArousal(20.0,MOD_Naivety)
	endif
	
	bool isAroused = (is_aroused_for>0)
	had_orgasm = false
	had_handle_orgasm = true
	; Check for chance on arousal
	IsArousedAfterSex(MOD_Daring)
	float chance = 0.0
	if is_aroused_for > 0
		; Check for chance on orgasm
		if hadVaginalSex
			chance = MOD_Vaginal
		endif
		if hadAnalSex && MOD_Anal > chance
			chance = MOD_Anal
		endif
		if hadOralSex && chance == 0.0
			chance = MOD_Oral
		elseif (hadOralSex && virgin_status_oral == 1) && MOD_Oral > chance
			chance = MOD_Oral
		endif
	endif
	int virgin_results = 0
	if !actor_alias.has_sex_alone
	if virgin_status_same == 1
		if HasPlayer && actorSex == DOM01.DOMPlayerAlias.GetPlayerSex()
			virgin_status_same = 2
			IncreaseArousal(10.0,MOD_Daring)
			SetNextPraiseReasonSilent(26) ; "giving virginity"
		else
			virgin_status_same = 3
		endif
		if ((actorSex%2) == 0)
			SendNotification("This was interesting! It looks like it was "+name+"'s first gay sex")
		else
			SendNotification("This was interesting! It looks like it was "+name+"'s first lesbian sex")
		endif
		chance *= 2.0
		virgin_results = 1
	endif
	if virgin_status_oral == 1
		SendNotification("This was unexpected! It looks like it was "+name+"'s first oral sex")
		if HasPlayer
			virgin_status_oral = 2
			IncreaseArousal(10.0,MOD_Oral)
			SetNextPraiseReasonSilent(27) ; "giving oral virginity"
		else
			virgin_status_oral = 3
		endif
		chance *= 2.0
		virgin_results += 2
	endif
	if virgin_status_anal == 1
		SendNotification("This was tense! It looks like it was "+name+"'s first time in the ass")
		if HasPlayer
			virgin_status_anal = 2
			IncreaseArousal(10.0,MOD_Anal)
			SetNextPraiseReasonSilent(28) ; "giving anal virginity"
		else
			virgin_status_anal = 3
		endif
		chance *= 2.0
		virgin_results += 4
	endif
	if virgin_status_vaginal == 1
		SendNotification("This was tight! It looks like "+name+" was a virgin")
		if HasPlayer
			virgin_status_vaginal = 2
			IncreaseArousal(10.0,MOD_Vaginal)
			SetNextPraiseReasonSilent(26) ; "giving virginity"
		else
			virgin_status_vaginal = 3
		endif
		chance *= 2.0
		virgin_results += 8
	endif
	if virgin_status_gang == 1
		SendNotification("This was fun! It looks like "+name+" never had a gangbang")
		if HasPlayer
			virgin_status_gang = 2
			IncreaseArousal(10.0,MOD_Creativity)
			SetNextPraiseReasonSilent(31) ; "being in a gangbang"
		else
			virgin_status_gang = 3
		endif
		chance *= 2.0
		virgin_results += 16
	endif
	endif
	
	;LogTrace("HandleSexOrgasm: "+name+" orgasm chance="+chance)
	if DOM01.DOMSexlab.separateOrgasmToggle
		;LogTrace("HandleSexOrgasm: "+name+" using SLSO")
		had_orgasm = had_separate_orgasm
		if IsOrgasmingAfterArousal(1000.0)
			if sex_is_non_consensual
				actor_alias.SendExternalEventSS("Orgasm","rape")
				DOM01.DOM04.NotifyOrgasm(actor_alias,"rape",should_be_noorgasm,was_allowed_toorgasm,true)
			elseif !actor_alias.has_sex_alone
				actor_alias.SendExternalEventSS("Orgasm","sex")
				DOM01.DOM04.NotifyOrgasm(actor_alias,"sex",should_be_noorgasm,was_allowed_toorgasm,false)
			else
				actor_alias.SendExternalEventSS("Orgasm","masturbate")
				DOM01.DOM04.NotifyOrgasm(actor_alias,"masturbate",should_be_noorgasm,was_allowed_toorgasm,false)
			endif
		endif
	elseif chance > 0.0
		if is_aroused_for > 0 && is_aroused_for < 10
			is_aroused_for = 10
		elseif is_aroused_for <= 0 && RandomFloat() < chance
			is_aroused_for = 10
			chance *= 0.3 ; default
		endif
		;LogTrace("HandleSexOrgasm: "+name+" orgasm chance with arousal factor="+chance)
		had_orgasm = IsOrgasmingAfterArousal(chance)
		if had_orgasm
			if sex_is_non_consensual
				actor_alias.SendExternalEventSS("Orgasm","rape")
				DOM01.DOM04.NotifyOrgasm(actor_alias,"rape",should_be_noorgasm,was_allowed_toorgasm,true)
			elseif !actor_alias.has_sex_alone
				actor_alias.SendExternalEventSS("Orgasm","sex")
				DOM01.DOM04.NotifyOrgasm(actor_alias,"sex",should_be_noorgasm,was_allowed_toorgasm,false)
			else
				actor_alias.SendExternalEventSS("Orgasm","masturbate")
				DOM01.DOM04.NotifyOrgasm(actor_alias,"masturbate",should_be_noorgasm,was_allowed_toorgasm,false)
			endif
		endif
	endif

	if virgin_results != 0
		if (virgin_results % 2) == 1 && virgin_status_same == 2 ; player
			DOM01.DOM04.NotifyLostVirginity(actor_alias,"same",had_orgasm,sex_is_non_consensual)
			actor_alias.SendExternalEventSS("LostVirginity","same")
		endif
		if (virgin_results % 4)/2 == 2 && virgin_status_oral == 2 ; player
			DOM01.DOM04.NotifyLostVirginity(actor_alias,"oral",had_orgasm,sex_is_non_consensual)
			actor_alias.SendExternalEventSS("LostVirginity","oral")
		endif
		if (virgin_results % 8)/4 == 1 && virgin_status_anal == 2 ; player
			DOM01.DOM04.NotifyLostVirginity(actor_alias,"anal",had_orgasm,sex_is_non_consensual)
			actor_alias.SendExternalEventSS("LostVirginity","anal")
		endif
		if (virgin_results % 16)/8 == 1 && virgin_status_vaginal == 2 ; player
			DOM01.DOM04.NotifyLostVirginity(actor_alias,"vaginal",had_orgasm,sex_is_non_consensual)
			actor_alias.SendExternalEventSS("LostVirginity","vaginal")
		endif
		if (virgin_results % 32)/16 == 1 && virgin_status_gang == 2 ; player
			DOM01.DOM04.NotifyLostVirginity(actor_alias,"gang",had_orgasm,sex_is_non_consensual)
			actor_alias.SendExternalEventSS("LostVirginity","gang")
		endif
	endif
	
	if HasPlayer
		DOM01.DOMPlayerAlias.HasFlingWith(actor_alias)
	elseif actor_alias.has_sex_alone
		SetNextPraiseReasonSilent(20) ; "being a lustful pet"
	elseif actor_alias.GetSexTrainer() == None
		if had_orgasm
			SetNextPraiseReasonSilent(54) ; "being a lustful whore"
		else
			SetNextPraiseReasonSilent(53) ; "being a good whore"	
		endif
	endif
EndFunction

Event handleSexEndEvent(int tid, bool HasPlayer)
	;LogTrace("handleSexEndEvent HasPlayer="+HasPlayer+" punishing_trainee_or_trainer="+punishing_trainee_or_trainer)
	if hasPlayer && punishing_trainee_or_trainer
		LogTrace("handleSexEndEvent CORRECTION HasPlayer="+HasPlayer+" punishing_trainee_or_trainer="+punishing_trainee_or_trainer)
		punishing_trainee_or_trainer = false
	endif
	if !had_handle_orgasm
		handleSexOrgasmEvent(tid, HasPlayer)
	endif
	
	sslThreadController controller = DOM01.DOMSexlab.GetController(tid)
	sslBaseAnimation anim = controller.Animation
	
	handleSexEnd(anim.GetRawTags(), HasPlayer)
	
	string formid = DOM_Util.ConvertIDToHex(akRef.GetFormID())
	UnregisterForModEvent("HookAnimationEnd_"+"DOM" +formid+"END")
EndEvent

string[] sex_global_tags
Function SetSexTags(string[] anim)
	RegisterForSexEvents() ; temporary fix for SLP+
	sex_global_tags = anim
EndFunction

string[] Function GetSexTags()
	return sex_global_tags
EndFunction

Function handleSexEnd(string[] anim, bool HasPlayer)
	
	;LogTrace("handleSexEnd HasPlayer="+HasPlayer+" punishing_trainee_or_trainer="+punishing_trainee_or_trainer)
	if hasPlayer && punishing_trainee_or_trainer
		LogTrace("handleSexEnd CORRECTION HasPlayer="+HasPlayer+" punishing_trainee_or_trainer="+punishing_trainee_or_trainer)
		punishing_trainee_or_trainer = false
	endif

	string hh = "girl"
	if ((actorSex%2) == 0) 
		hh = "boy"
	endif

	LogTrace("HandleSexEnd: Teaching "+GetMoodNameThirdPerson()+name+" how to be a good "+hh+" sex_is_non_consensual="+sex_is_non_consensual+" Dominant="+sex_is_dominant+" threesome="+sex_is_threesome)
	Actor actor_current_trainer = actor_alias.GetCurrentSexTrainer()
	
	if akRef.IsInFaction(DOM01.DOMActionTraining) || sex_is_dominant
		DOM_Actor theTrainee = actor_alias.GetCurrentTrainee()
		if theTrainee != None
			SendNotificationAbuse(name+" had fun sex training "+theTrainee.GetName())
			if sex_is_non_consensual
				TrainSkillPredator(0.5)
				SetNextPraiseReasonSilent(51) ; "being a good sex trainer"
				CheckAndRegisterKink(102,1.0) ; "training sex slaves"
			else
				TrainSkillDeceiver(0.5)
				SetNextPraiseReasonSilent(44) ; "being a devoted slaver"
				CheckAndRegisterKink(104,1.0) ; "breaking slaves"
			endif
		else
			DOM_Actor thepartner = actor_alias.GetSexTrainer()
			if thePartner != None
				SendNotificationAbuse(name+" had fun with "+thePartner.GetName())
				if actor_alias.is_trainer || !is_slave
					if sex_is_non_consensual
						TrainSkillPredator(0.5)
						SetNextPraiseReasonSilent(51) ; "being a good sex trainer"
						CheckAndRegisterKink(102,1.0) ; "training sex slaves"
					else
						TrainSkillDeceiver(0.5)
						SetNextPraiseReasonSilent(44) ; "being a devoted slaver"
						CheckAndRegisterKink(104,1.0) ; "breaking slaves"
					endif
				endif
			else
				Actor theActor = actor_alias.GetActorPartner()
				if theActor != None
					SendNotificationAbuse(name+" had fun with "+theActor.GetDisplayName())
				else
					SendNotificationAbuse(name+" had sex with someone")
				endif
			endif
		endif
	elseif !actor_alias.has_sex_alone
		SendNotificationAbuse("Teaching "+ GetMoodNameThirdPerson()+name+" how to be a good "+hh)
		if sex_is_non_consensual
			DOM01.TrainSkillPredator(actor_current_trainer,0.5)
		else
			DOM01.TrainSkillDeceiver(actor_current_trainer,0.5)
		endif
		if hasPlayer
			DOM01.DOMPlayerAlias.HasFlingWith(actor_alias)
		endif
		if actor_alias.has_sex_for_money
			SetNextPraiseReasonSilent(53) ; "being a good whore"
			CheckAndRegisterKink(67,1.0) ; "being whored"
		endif
	else
		SendNotificationAbuse(GetMoodNameThirdPerson()+name+" taught "+actorObjective+"self how to be a good "+hh)
	endif

	if HasPlayer
		LogTrace("handleSexEnd calling NotifyEndSex")
		DOM01.DOM04.NotifyEndSex(actor_alias,current_punishment_type,current_punishment_reason_name,hadOralSex,hadVaginalSex,hadAnalSex,had_orgasm,sex_is_non_consensual)
		actor_alias.SendExternalEventSSSB("Sex",current_punishment_type,current_punishment_reason_name,had_orgasm)
	endif
	if sex_is_non_consensual
		if hasPlayer
			LogTrace("HandleSexEnd EndPunishing punishing by player "+GetMoodNameThirdPerson()+name)
			EndPunishing(PlayerRef,"rape")
		elseif actor_alias.GetSexTrainer() != None
			LogTrace("HandleSexEnd EndPunishing punishing by partner "+actor_alias.GetSexTrainer().GetName()+" "+GetMoodNameThirdPerson()+name)
			EndPunishing(actor_alias.GetSexTrainer().akRef,"rape")
		elseif actor_alias.GetActorPartner() != None
			LogTrace("HandleSexEnd EndPunishing punishing by NPC "+actor_alias.GetActorPartner().GetDisplayName()+" "+GetMoodNameThirdPerson()+name)
			EndPunishing(actor_alias.GetActorPartner(),"rape")
		elseif actor_alias.GetTrainer() != None
			LogTrace("HandleSexEnd EndPunishing punishing by trainer "+GetMoodNameThirdPerson()+name)
			EndPunishing(actor_alias.GetTrainer().akRef,"rape")
		else
			LogTrace("HandleSexEnd EndPunishing punishing by NONE "+GetMoodNameThirdPerson()+name)
			EndPunishing(actor_current_trainer,"rape")
		endif
	else
		if hasPlayer
			LogTrace("HandleSexEnd had sex with player "+GetMoodNameThirdPerson()+name)
		elseif actor_alias.has_sex_alone
			LogTrace("HandleSexEnd had sex alone "+GetMoodNameThirdPerson()+name)
		elseif actor_alias.GetSexTrainer() != None
			LogTrace("HandleSexEnd had sex with partner "+actor_alias.GetSexTrainer().GetName()+" "+GetMoodNameThirdPerson()+name)
		elseif actor_alias.GetActorPartner() != None
			LogTrace("HandleSexEnd had sex with NPC "+actor_alias.GetActorPartner().GetDisplayName()+" "+GetMoodNameThirdPerson()+name)
		else
			LogTrace("HandleSexEnd had sex with NONE "+GetMoodNameThirdPerson()+name)
		endif
	endif
	
	;if sex_is_non_consensual
	;	PrintTrainingBefore("rape end",1.0,"sex")
	;else
	;	PrintTrainingBefore("sex end",1.0,"sex")
	;endif
	
	if hidden_kinks_nb > 0 && !actor_alias.has_sex_alone
		; both Dominant and submissive positions
		if HasTag(anim,"Kissing")
			CheckAndRegisterKink(30,2.0) ; "being kissed"
		endif
		if (HasTag(anim,"Forced") || HasTag(anim,"Rough") || HasTag(anim,"Aggressive")) 
			CheckAndRegisterKink(32,1.0) ; "having rough sex"
		endif
		if HasTag(anim,"Loving")
			CheckAndRegisterKink(34,2.0) ; "having loving sex"
		endif
		if (sex_is_threesome || HasTag(anim,"Orgy")) 
			CheckAndRegisterKink(35,2.0) ; "having a threesome"
		endif
		if actor_alias.is_in_dungeon
			CheckAndRegisterKink(36,1.5) ; "doing it in a dungeon"
		endif
		if actor_alias.is_in_city
			CheckAndRegisterKink(37,1.5) ; "doing it in a public place"
		endif
		if ((actorSex%2) == 1) && HasTag(anim,"Lesbian") 
			CheckAndRegisterKink(48,1.0) ; "doing it with another girl"
		endif
		if ((actorSex%2) == 0) && HasTag(anim,"Gay") 
			CheckAndRegisterKink(48,1.0) ; "doing it with another dude"
		endif
		if HasTag(anim,"69")
			CheckAndRegisterKink(50,2.0) ; "doing a 69"
		endif
		if sex_with_creature || HasTag(anim,"Creature")  
			CheckAndRegisterKink(57,2.0) ; "being fucked by a creature"
		endif
		if sex_with_animal || HasTag(anim,"Animal") 
			CheckAndRegisterKink(58,2.0) ; "being fucked by an animal"
		endif
		if sex_with_undead || HasTag(anim,"Undead") 
			CheckAndRegisterKink(59,2.0) ; "being fucked by the undead"
		endif
		if sex_with_animunculi || HasTag(anim,"DwarvenBallistas") || HasTag(anim,"DwarvenCenturion") || HasTag(anim,"DwarvenSphere") || HasTag(anim,"DwarvenSpider")
			CheckAndRegisterKink(89,2.0) ; "being fucked by a animunculi"
		endif
		if sex_with_taboo
			CheckAndRegisterKink(60,2.0) ; "having taboo sex"
		endif
		if sex_is_interracial
			CheckAndRegisterKink(63,2.0) ; "having interracial sex"
		endif
		if sex_with_inlaw
			CheckAndRegisterKink(64,2.0) ; "having sex with an inlaw"
		endif
		if sex_with_relative
			CheckAndRegisterKink(65,2.0) ; "having sex with a relative"
		endif
		
		; submissive position
		if !sex_is_dominant
			if sex_is_non_consensual
				CheckAndRegisterKink(31,1.0) ; "being raped"
			endif
			if (actor_alias.behaviour == "tied" || HasTag(anim,"Bound")) 
				CheckAndRegisterKink(33,2.0) ; "having tied-up sex"
			endif
			if HasTag(anim,"Handjob")
				CheckAndRegisterKink(40,2.0) ; "giving a handjob" 
			endif
			if HasTag(anim,"Footjob")
				CheckAndRegisterKink(41,2.0) ; "giving a footjob"
			endif
			if ((actorSex%2) == 1) && HasTag(anim,"Boobjob")
				CheckAndRegisterKink(42,2.0) ; "giving a boobjob"
			endif
			if HasTag(anim,"Blowjob")
				CheckAndRegisterKink(43,1.0) ; "giving a blowjob"
			endif
			if HasTag(anim,"Creampie")
				CheckAndRegisterKink(44,2.0) ; "getting creampied"
			endif
			if HasTag(anim,"Facial")
				CheckAndRegisterKink(45,2.0) ; "getting a facial"
			endif
			if HasTag(anim,"CumInMouth")
				CheckAndRegisterKink(46,2.0) ; "getting cum in mouth"
			endif
			if HasTag(anim,"Cunnilingus")
				CheckAndRegisterKink(47,1.0) ; "giving a cunnilingus"
			endif
			if HasTag(anim,"Fisting")
				CheckAndRegisterKink(49,2.0) ; "getting fisted"
			endif
			if (HasTag(anim,"Holding") || HasTag(anim,"Hugging"))
				CheckAndRegisterKink(51,2.0) ; "being held while fucked"
			endif
			if (HasTag(anim,"Cowgirl") || HasTag(anim,"ReverseCowgirl"))
				CheckAndRegisterKink(52,2.0) ; "being fucked cowgirl style"
			endif
			if (HasTag(anim,"Doggy") || HasTag(anim,"Doggystyle"))
				CheckAndRegisterKink(53,2.0) ; "being fucked doggy style"
			endif
			if HasTag(anim,"Standing")
				CheckAndRegisterKink(54,2.0) ; "being fucked standing"
			endif
			if hadAnalSex
				CheckAndRegisterKink(55,1.0) ; "getting fucked in the ass" 
			endif
			if __drunk_level > 1
				CheckAndRegisterKink(56,2.0) ; "getting fucked while drunk"
			endif
		elseif !sex_is_threesome ; Dominant position ignores threesomes to avoid confusion
			if ((actorSex%2) == 0) && HasTag(anim,"Handjob")
				CheckAndRegisterKink(110,2.0) ; "getting a handjob" 
			endif
			if ((actorSex%2) == 1) && HasTag(anim,"Hands")
				CheckAndRegisterKink(110,2.0)  ; "getting fondled by hand"  
			endif
			if ((actorSex%2) == 0) && HasTag(anim,"Footjob")
				CheckAndRegisterKink(111,2.0) ; "getting a footjob" 
			endif
			if ((actorSex%2) == 1) && HasTag(anim,"Feet")
				CheckAndRegisterKink(111,2.0) ; "getting fondled by foot"
			endif
			if ((actorSex%2) == 0) && HasTag(anim,"Boobjob") ; "getting a boobjob" 
				CheckAndRegisterKink(112,2.0)
			endif
			if ((actorSex%2) == 0) && HasTag(anim,"Blowjob") ; "getting a blowjob" 
				CheckAndRegisterKink(113,1.0)
			endif
			if ((actorSex%2) == 1) && HasTag(anim,"Cunnilingus")
				CheckAndRegisterKink(113,1.0) ; "getting a cunnilingus" 
			endif
			if HasTag(anim,"Fisting") && HasHiddenKink(119)
				CheckAndRegisterKink(119,2.0) ; "fisting someone"
			endif
			if (HasTag(anim,"Cowgirl") || HasTag(anim,"ReverseCowgirl"))
				CheckAndRegisterKink(122,2.0) ; "doing it cowgirl style"
			endif
			if (HasTag(anim,"Doggy") || HasTag(anim,"Doggystyle"))
				CheckAndRegisterKink(123,2.0) ; "doing it  doggy style"
			endif
			if HasTag(anim,"Standing")
				CheckAndRegisterKink(124,2.0) ; "doing it standing"
			endif
			if HasTag(anim,"Anal")
				CheckAndRegisterKink(125,1.0) ; "fucking someone in the ass"
			endif
			if __drunk_level > 1
				CheckAndRegisterKink(126,2.0) ; "fucking while drunk"
			endif
		endif
	endif
	;LogTrace("handleSexEnd calling OnEndSex mood="+mood)
	OnEndSex(had_orgasm)
	if !IsSad()
		if sex_is_non_consensual || HasTag(anim,"Forced") || HasTag(anim,"Rough") || HasTag(anim,"Aggressive")
			MakeSadFor(10.0)
		endif
	endif
	if HasTag(anim,"Oral")
		SetNextPraiseReasonSilent(55) ; "sucking like a queen"
	endif
	if HasTag(anim,"Vaginal")
		SetNextPraiseReasonSilent(56) ; "having a soft pussy"
	endif
	if HasTag(anim,"Anal")
		SetNextPraiseReasonSilent(57) ; "being an ass whore"
		float x = (anal_training/100.0 + MOD_Rebellion)/2.0
		if RandomFloat() > x
			actor_alias.TryApplyTears()
		endif
	endif
	if !IsSad()
		if sex_is_non_consensual
			MakeAshamedFor(10.0)
		endif
	endif
		
	;if sex_is_non_consensual
	;	PrintTrainingAfter("rape end",1.0,"sex")
	;else
	;	PrintTrainingAfter("sex end",1.0,"sex")
	;endif

	if HasPlayer
		RedressAfterSex(None)
	else
		RedressAfterSex(actor_current_trainer)
	endif

	actor_alias.OnSexEnd()
	
	hadAnalSex = false
	hadOralSex = false
	hadVaginalSex = false		

	sex_active = false
	sex_is_non_consensual = false
	sex_is_dominant = false
	sex_is_threesome = false
	sex_is_interracial = false
	sex_with_player = false
	sex_with_animal = false
	sex_with_undead = false
	sex_with_creature = false
	sex_with_animunculi = false
	sex_with_taboo = false
	sex_with_inlaw = false
	sex_with_relative = false
EndFunction

Function StartSexualAbuse()
	abuse_type = "sexual"
	hadOralSex = false
	hadAnalSex = false
	hadVaginalSex = false
	ticks_since_last_punished = 0
	time_last_abused = GetCurrentGameTime()
	time_last_resilience = time_last_abused
EndFunction

Function TrainAfterSex(Float multiplier, Float trainCount)
	if trainCount == 0
		trainVaginal(5.0 * multiplier)
		return
	endif
	TrainSubmission(multiplier*0.5)
	TrainHumiliation(multiplier*0.25)
	TrainRespect(multiplier*0.25)
	float mult_count = multiplier / trainCount
	if hadAnalSex
		trainAnal(5.0 * mult_count)
	endif
	if hadOralSex
		trainOral(5.0 * mult_count)
	endif
	if hadVaginalSex
		trainVaginal(5.0 * mult_count)
	endif
	
	if actor_alias.has_plug_vaginal
		if actor_alias.has_dwarven_device 
			if hadOralSex
				trainVaginal(1.5 * mult_count)
			endif
			if hadAnalSex
				trainVaginal(3.0 * mult_count)
			endif
		else
			if hadOralSex
				trainVaginal(1.25 * mult_count)
			endif
			if hadAnalSex
				trainVaginal(2.5 * mult_count)
			endif
		endif
	endif
	
	if actor_alias.has_plug_anal
		if actor_alias.has_dwarven_device 
			if hadOralSex
				trainAnal(1.5 * mult_count)
			endif
			if hadVaginalSex
				trainAnal(3.0 * mult_count)
			endif
		else
			if hadOralSex
				trainAnal(1.25 * mult_count)
			endif
			if hadVaginalSex
				trainAnal(2.5 * mult_count)
			endif
		endif
	endif
EndFunction

bool Function IsArousedAfterSex(Float base_chance)
	;LogTrace("IsArousedAfterSex() arousal_factor="+arousal_factor+" enraptured="+__is_enraptured_for+" aroused="+is_aroused_for)
	if arousal_factor < 100.0
		return false
	endif
	; Only for female / or males who recovered from last orgasm
	if ((actorSex%2) == 0) && __is_enraptured_for > 0
		return false
	endif
	if __is_aroused_for > 0 ; maintain arousal
		__is_aroused_for = (FACET_Sensuality*0.5+submission*0.5) as int
		return false
	endif
	if RandomFloat()*100.0 < submission || RandomFloat()*10.0 < base_chance
		float chance
		if hadVaginalSex && MOD_Vaginal > chance
			chance = MOD_Vaginal
		elseif hadAnalSex && MOD_Anal > chance
			chance = MOD_Anal
		elseif hadOralSex && MOD_Oral > chance
			chance = MOD_Oral
		elseif IsDevoted()
			chance = MOD_Daring
		else
			chance = MOD_Ingenuity
		endif

		if RandomFloat() < chance 
			;LogTrace("IsArousedAfterSex() Got aroused after sex chance="+chance+" mod="+base_chance+" sub="+submission)
			if __is_enraptured_for > 0
				is_enraptured_for = 0
			endif
			is_aroused_for = (FACET_Sensuality*0.5+submission*0.5) as int
			AddNextPraiseReason(19) ; "being a good horny pet"
			return true
			;LogTrace("IsArousedAfterSex() Not aroused spontaneously chance="+chance+" mod="+base_chance+" sub="+submission)
		endif
	endif
	return false
EndFunction

bool Function IsArousedAfterShame(Float base_chance)
	;LogTrace("IsArousedAfterShame() arousal_factor="+arousal_factor+" enraptured="+__is_enraptured_for+" aroused="+is_aroused_for)
	if arousal_factor < 100.0
		return false
	endif
	; Only for female / or males who recovered from last orgasm
	if ((actorSex%2) == 0) && __is_enraptured_for > 0
		return false
	endif
	if is_aroused_for > 0 ; maintain arousal
		is_aroused_for = (FACET_Sensuality*0.5+humiliation*0.5) as int
		return false
	endif
	if RandomFloat()*100.0 < humiliation || RandomFloat()*10.0 < base_chance
		float chance
		if IsDevoted()
			chance = MOD_Daring
		else
			chance = MOD_Ingenuity
		endif

		if RandomFloat() < chance 
			;LogTrace("IsArousedAfterShame()  Got aroused after shame chance="+chance+" mod="+base_chance+" hum="+humiliation)
			if __is_enraptured_for > 0
				is_enraptured_for = 0
			endif
			if is_aroused_for == 0
				actor_alias.ChooseAnswerAroused(PlayerRef)
			endif
			is_aroused_for = (FACET_Sensuality*0.5+humiliation*0.5) as int
			; actor_alias.TryApplyBlush()
			AddNextPraiseReason(19) ; "being a good horny pet"
			return true
		else
			;LogTrace("IsArousedAfterShame() Not aroused spontaneously chance="+chance+" mod="+base_chance+" hum="+humiliation)
		endif
	endif
	return false
EndFunction

Function IsArousedSpontaneously(Float base_chance)
	;LogTrace("IsArousedSpontaneously() arousal_factor="+arousal_factor+" enraptured="+__is_enraptured_for+" aroused="+is_aroused_for)
	if arousal_factor < 100.0
		return
	endif
	; Only for female / or males who recovered from last orgasm
	if ((actorSex%2) == 0) && __is_enraptured_for > 0
		return
	endif
	if is_aroused_for > 10 ; ignore
		return
	endif
	float training = (humiliation+submission)/2.0
	if RandomFloat()*100.0 < training || RandomFloat()*10.0 < base_chance
		float chance = MOD_Ingenuity

		if RandomFloat() < chance 
			;LogTrace("IsArousedSpontaneously() Got aroused spontaneously chance="+chance+" mod="+base_chance+" (sub+hum)/2="+training)
			if __is_enraptured_for > 0
				is_enraptured_for = 0
			endif
			if is_aroused_for == 0
				actor_alias.ChooseAnswerAroused(PlayerRef)
			endif
			is_aroused_for = (FACET_Sensuality*0.5+training*0.5) as int
			; actor_alias.TryApplyBlush()
			SetNextPraiseReasonSilent(19) ; "being a good horny pet"
		;else
		;	LogTrace("IsArousedSpontaneously() Not aroused spontaneously chance="+chance+" mod="+base_chance+" (sub+hum)/2="+training)
		endif
	endif
EndFunction

bool Function IsOrgasmingAfterArousal(Float base_chance)
	LogTrace("IsOrgasmingAfterArousal() arousal_factor="+arousal_factor+" enraptured="+__is_enraptured_for+" aroused="+is_aroused_for)
    ; This is a chance to get orgasm
	if __is_aroused_for <= 0 ; no orgasm without arousal
		return false
	endif
	if ((actorSex%2) == 0) && __is_enraptured_for > 0 ; no double orgasm for male
		return false
	endif
	int enraptured_max = ((MOD_Orgasm)*10.0 + (submission)*0.5) as int
	if enraptured_max < 4
		enraptured_max = 4
	endif
	if ((actorSex%2) == 1)
		if __is_enraptured_for > enraptured_max-(4) ; // no double orgasm for 4 ticks for female
			return false
		endif
	endif
	float chance = base_chance*MOD_Orgasm*DOM01.train_speed_orgasm
	if chance > 0.5
		chance = 0.5 + (chance-(0.5))/20.0
	endif
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: base="+base_chance+" mod="+MOD_Orgasm+" chance="+chance)
	if ((actorSex%2) == 0)
		chance = chance*2.0+0.1 ; Males gets higher chance for orgasm, but less effect
	endif

	chance += getArousalBonus()
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: after mood bonus="+chance)
	if WasWarned(19) || WasWarned(21) ; "didnt masturbate" || "no_sex"
		chance += 0.1
	endif
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: after warning="+chance+" warn="+__warn_punishment_reason_name)

	if whipping_active
		if whipping_reason == 19 || whipping_reason == 21 ; "didnt masturbate" || "no_sex"
			chance += 0.1
		endif
		if RandomFloat() < FACET_Submissivity ; submissive
			chance += 0.1
		endif
	endif
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: after psh="+chance+" psh="+whipping_reason_name)

	if __should_be_noorgasm
		if IsDevoted() ; Loving slaves
			if was_allowed_toorgasm
				if submission >= 100.0 
					if RandomFloat()*100.0 < love_desire
						chance += 0.35
					else
						chance += 0.25
					endif
				elseif RandomFloat()*100.0 < submission
					chance += 0.2
				else
					chance += 0.15
				endif
			elseif submission >= 100.0 
				if RandomFloat()*100.0 < love_desire
					chance -= 0.35
				else
					chance -= 0.25
				endif
			elseif RandomFloat()*100.0 < submission
				chance -= 0.2
			else
				chance -= 0.15
			endif
		elseif was_allowed_toorgasm ; fresh slaves
			if RandomFloat()*100.0 < submission
				chance += 0.15
			else
				chance += 0.1 ; still some effects trying to fight it
			endif
		elseif RandomFloat()*100.0 < submission
			chance -= 0.15
		else
			chance += 0.2 ; counter effect trying to fight it
		endif
	endif
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: after no org="+chance+" orgasm control="+__should_be_noorgasm)
	if promiseOath == "rapture"
		if RandomFloat()*100.0 < submission
			chance += 0.1
		elseif RandomFloat()*100.0 < FACET_Sensuality
			chance += 0.2 ; counter effect trying to fight it
		endif
	endif
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: after promise="+chance+" promise="+promiseOath)

	if !actor_alias.canAnimate && abuse_type == "sex" 
		if actor_alias.has_sex_with_player
			chance += 0.1 ; bonus for loving sex (should depend on actor having sex with slave)
			if number_of_sex == 0
				chance += 0.1 ; bonus for first time with player
			endif
		endif
	endif
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: after psh type="+chance+" psh="+abuse_type)

	if number_of_sex == 0 && actor_alias.has_sex_with_player
		chance += 0.1 ; bonus for first time
	endif

	if number_of_sexformoney == 0 && actor_alias.has_sex_for_money
		chance += 0.1 ; bonus for first time
	endif
	
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: first time="+chance+" n="+number_of_sex)

	if number_of_orgasm > 0
		chance += number_of_orgasm*0.01 ; each past orgasm gives a 1%
	endif
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: after nb org="+chance+" nb="+number_of_orgasm)

	chance *= 1.0+arousal_factor/1000.0 ; arousal bonus
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: after arousal="+chance+" arousal="+arousal_factor+" mod="+1.0+arousal_factor/1000.0)
	
	chance += submission/1000.0
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: after submission bonus="+chance+" submission="+submission)

	chance += love_desire/200.0
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: after love desire bonus="+chance+" love desire="+love_desire)

	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: chance="+chance+" base="+base_chance+" mod="+MOD_Orgasm+" arousal="+arousal_factor)
	had_orgasm = false
	float x = RandomFloat()
	;LogTrace("IsOrgasmingAfterArousal() Try orgasm chance: chance="+chance+" x="+x+" base="+base_chance+" mod="+MOD_Orgasm+" arousal="+arousal_factor)
	if  x < chance ; 
		actor_alias.SexlabPlayOrgasm(true)
		CheckWasAllowedToOrgasm()
		float amount = MOD_Daring*10.0
		if ((actorSex%2) == 0)
			amount *= 0.20 ; less effect on personality
			if !__should_be_noorgasm
				SendNotification(name+"'s brain melts, as "+actorPronoun+" is submerged by orgasm")
			elseif IsDevoted()
				if was_allowed_toorgasm
					SendNotification(name+"'s brain melts, as "+actorPronoun+" is finally submerged by orgasm")
				else
					SendNotification(name+"'s brain melts, as "+actorPronoun+" is unexpectedly submerged by orgasm")
				endif
			else ; not devoted
				if was_allowed_toorgasm
					SendNotification(name+"'s brain melts, as "+actorPronoun+" is unwillingly submerged by orgasm")
				else
					SendNotification(name+"'s brain melts, as "+actorPronoun+" is suprisingly submerged by orgasm")
				endif
			endif
		else
			if !__should_be_noorgasm
				SendNotification(name+"'s brain melts, as "+actorPronoun+" is submerged by orgasm")
			elseif IsDevoted()
				if was_allowed_toorgasm
					SendNotification(name+"'s brain melts, as "+actorPronoun+" is finally submerged by orgasm")
				else
					SendNotification(name+"'s brain melts, as "+actorPronoun+" is unexpectedly submerged by orgasm")
				endif
			else ; not devoted
				if was_allowed_toorgasm
					SendNotification(name+"'s brain melts, as "+actorPronoun+" is unwillingly submerged by orgasm")
				else
					SendNotification(name+"'s brain melts, as "+actorPronoun+" is suprisingly submerged by orgasm")
				endif
			endif
		endif
		if promiseOath == "rapture"
			promise_kept = 1
		endif

		;LogTrace("is submerged by orgasm. Amount = "+amount)
		number_of_orgasm += 1
		amount *= 5.0/(number_of_orgasm+5.0) ; less efficient after a few orgasms
		if !DOM01.staticTraitsMode
			if is_slave 
				FACET_Submissivity  = FACET_Submissivity + amount * DOM_Util.RandG1()
				FACET_Sensuality    = FACET_Sensuality + amount * DOM_Util.RandG1()
				HEXACO_Openness     = HEXACO_Openness + amount * DOM_Util.RandG1()
			else
				FACET_Submissivity  = FACET_Submissivity - amount * DOM_Util.RandG1()
				HEXACO_Extraversion = HEXACO_Extraversion + amount * DOM_Util.RandG1()
				HEXACO_Honesty      = HEXACO_Honesty - amount * DOM_Util.RandG1()
			endif
			; Compute modifiers & update
			; ResetModifiers() ; this is done automatically
		endif
		
		is_enraptured_for = enraptured_max
		;LogTrace("IsOrgasmingAfterArousal() enraptured for = "+__is_enraptured_for+" -> ( "+MOD_Orgasm+" + "+submission+" )")
		if ((actorSex%2) == 0) ; stop arousal for males
			is_aroused_for = 2
			arousal_factor = 10.0
		else
			is_aroused_for = 2+is_aroused_for / 2
			arousal_factor = 10.0+arousal_factor / 2.0
		endif
		; AddNextPraiseReason(19) ; "being a good horny pet" THIS IS DONE IN CheckWasAllowedToOrgasm()
		actor_alias.Anim_Orgasm()
		had_orgasm = true
	endif
	;was_allowed_toorgasm = false
	return had_orgasm
EndFunction

Function SetAllowOrgasm()
	if !__should_be_noorgasm
		SendNotification(name+" is not subject to your orders on that matter. You need to turn on orgasm control for "+actorObjective)		
		return
	endif
	if !actor_alias.canAnimate || __is_aroused_for > 0
		if was_allowed_toorgasm
			if IsDevoted()
				SendNotification(name+" tries hard not to get an orgasm")		
				IncreaseArousal(10.0,__MOD_Discipline)
			else
				SendNotification(name+" is ordered not to get an orgasm")
				IncreaseArousal(5.0,__MOD_Discipline)
			endif
			was_allowed_toorgasm = false
			return
		endif
		if IsDevoted()
			SendNotification(name+" gets excited being allowed to orgasm")		
			IncreaseArousal(10.0,__MOD_Discipline)
		else
			SendNotification(name+" is confused being allowed to orgasm")		
			IncreaseArousal(5.0,__MOD_Discipline)
		endif
		was_allowed_toorgasm = true
		return
	endif

    ; no changes
	SendNotification(name+" is not sufficiently aroused")	
	;was_allowed_toorgasm = false 
EndFunction

; ### Drinking and alcoholism

bool drunk_passedout = false
bool drugged_passedout = false
int __drunk_level = 0
int Property drunk_level Hidden
	int Function get()
		return __drunk_level
	EndFunction
	Function set(int value)
		if __drunk_level == value
			return
		endif
		__drunk_level = value
		if __drunk_level >= 3
			actor_alias.Anim_DrunkStart()
		else
			actor_alias.Anim_DrunkStop()
		endif

		RegisterForUpdateChanceRunAway()
		RegisterForUpdateChanceRunAwayGang()
		actor_alias.SendExternalEventSI("DrunkennessChange",__drunk_level)
		if __drunk_level > 0
			akRef.SetFactionRank(DOM01.DOMDrunkLevel, __drunk_level)
			if __drunk_level > 2
				DOM01.DOM04.NotifyDrunk(actor_alias,"drunk",__drunk_level, drunk_passedout)
			endif
		else
			akRef.RemoveFromFaction(DOM01.DOMDrunkLevel)
		endif
	EndFunction
EndProperty

float drunk_traits_save01
float drunk_traits_save02
float drunk_traits_save06
float drunk_traits_save07
float drunk_traits_save08
float drunk_traits_save10
float intake_alcohol = 0.0
float blood_alcohol = 0.0
float intake_alcohol_time = 0.0
float intake_alcohol_last_time = 0.0
float intake_alcohol_start_level = 0.0
float blood_alcohol_time = 0.0
float blood_alcohol_last_time = 0.0
float blood_alcohol_start_level = 0.0

int Function GetDrunkLevel()
	;LogTrace("GetDrunkLevel "+__drunk_level)
	return __drunk_level ; 0=clean 7=should be dead
EndFunction

Float Function GetBloodAlcohol()
	return blood_alcohol 
EndFunction

bool Function IsDrunkPassedout()
	return drunk_passedout
EndFunction

bool Function IsPassedOut()
	if drunk_passedout
		;LogTrace("IsPassedOut true drunk")
		return true
	endif
	return IsPassedOutNotDrunk()
EndFunction

bool Function IsPassedOutNotDrunk()
	if drugged_passedout
		;LogTrace("IsPassedOutNotDrunk true drugged")
		drugged_passedout = false
		return true
	endif
	if akRef.IsUnconscious()
		;LogTrace("IsPassedOutNotDrunk true unconscious")
		return true
	endif
	if akRef.GetActorValue("Paralysis") != 0.0
		;LogTrace("IsPassedOutNotDrunk true paralyzed")
		return true
	endif
	if akRef.IsDead()
		;LogTrace("IsPassedOutNotDrunk true dead")
		return true
	endif
	if akRef.GetSleepState() == 3
		;LogTrace("IsPassedOutNotDrunk true sleeping")
		return true
	endif
	return false
EndFunction

Function MakeSober()
	if __drunk_level > 0
		RestoreTraitsAfterDrunk()
		SendNotificationAbuse(name+" is now sober")
	endif
	drunk_level = 0
	LogTrace("MakeSober drunk_level="+__drunk_level)
	blood_alcohol = 0.0
	blood_alcohol_time = 0.0
	blood_alcohol_last_time = 0.0
	blood_alcohol_start_level = 0.0
	if intake_alcohol <= 0.0
		intake_alcohol = 0.0
		intake_alcohol_time = 0.0 
		intake_alcohol_last_time = 0.0 
		intake_alcohol_start_level = 0.0 
	endif
	drunk_passedout = false
	akRef.SetUnconscious(false)
	actor_alias.Anim_DrunkReset()
	Wait(1.0)
	LogTrace("MakeSober Anim_IdleReset")
	actor_alias.Anim_IdleReset()
EndFunction

Function SaveTraitsBeforeDrunk()
	drunk_traits_save01 = HEXACO_Emotionality
	drunk_traits_save02 = HEXACO_eXtraversion
	drunk_traits_save06 = FACET_Boldness
	drunk_traits_save07 = FACET_Wilfulness
	drunk_traits_save08 = FACET_Smartness
	drunk_traits_save10 = FACET_Toughness
EndFunction

Function RestoreTraitsAfterDrunk()
	HEXACO_Emotionality = drunk_traits_save01
	HEXACO_eXtraversion = drunk_traits_save02 
	FACET_Boldness      = drunk_traits_save06
	FACET_Wilfulness    = drunk_traits_save07
	FACET_Smartness     = drunk_traits_save08
	FACET_Toughness     = drunk_traits_save10
	; Compute modifiers & update
	; ResetModifiers()  ; this is done automatically
EndFunction

Function IngestNarcotic(Form the_drink)
	float amount = 0.05 + the_drink.GetGoldValue()/1000.0 ; skooma value between 20 and 67, sleeping tree sap 100
	number_of_drug += 1
	bool is_addicted = false
	if number_of_drug > (10.0 - MOD_Addict) && RandomFloat() < MOD_Addict
		is_addicted = true
	endif
	drugged_passedout = false
	if number_of_drug > (10.0 - MOD_Addict) && RandomFloat()*100.0 > FACET_Toughness
		drugged_passedout = true
	endif
	if is_addicted
		SendNotificationAbuse(name+" "+actorBeVerb+" is feeling more and more addicted to "+the_drink.GetName())
		HEXACO_Honesty           -= RandomFloat()*amount*2.0
		HEXACO_Emotionality      += RandomFloat()*amount*2.0
		HEXACO_eXtraversion      -= RandomFloat()*amount*2.0
		HEXACO_Agreeableness     -= RandomFloat()*amount*2.0
		HEXACO_Conscientiousness -= RandomFloat()*amount*2.0
		HEXACO_Openness          -= RandomFloat()*amount*2.0
		DOM01.DOM04.NotifyAddicted(actor_alias, the_drink.GetName(), "", drugged_passedout)
	else
		SendNotificationAbuse(name+" "+actorBeVerb+" now under the influence of "+the_drink.GetName())
		DOM01.DOM04.NotifyDrugged(actor_alias, the_drink.GetName(), "", drugged_passedout)
	endif
	if drugged_passedout
		if !IsPassedOutNotDrunk() 
			actor_alias.PushMeAway(0.0)
			SendNotificationAbuse(name+"'s head hits the ground")
			if RandomFloat()*100.0 < FACET_Wilfulness
				akRef.SetUnconscious()
			else
				drugged_passedout = false
			endif
		endif
	endif
EndFunction

Function IngestAlcohol(float amount)
	;LogTrace("IngestAlcohol amount="+amount+" before="+intake_alcohol)
	intake_alcohol += amount
	intake_alcohol_time = GetCurrentGameTime() ; Takes 1 hour to get in the blood
	intake_alcohol_last_time = intake_alcohol_time
	intake_alcohol_start_level = intake_alcohol
	;LogTrace("IngestAlcohol amount="+amount+" after="+intake_alcohol)
EndFunction

Function HandleAlcoholEffects()
	;LogTrace("alcohol = "+blood_alcohol+" level = "+__drunk_level)

	if blood_alcohol <= 0.0 ; Sober
		MakeSober()
		; drunk_level = 0 ; already included in MakeSober()
		return
	endif

	if __drunk_level == 0
		SaveTraitsBeforeDrunk()
	endif

	if blood_alcohol < 0.01 ; Same as sober
		drunk_level = 1
		IncreaseArousal(1.0,MOD_Daring)
		return
	endif

	float modifier = (FACET_Toughness+101.0-HEXACO_Emotionality)/100.0
	;LogTrace("alcohol = "+blood_alcohol+" tough    = "+FACET_Toughness)
	;LogTrace("alcohol = "+blood_alcohol+" anxious  = "+HEXACO_Emotionality)
	;LogTrace("alcohol = "+blood_alcohol+" modifier = "+modifier)
	float amount = 1.0-(2.0*blood_alcohol)/modifier
	HEXACO_eXtraversion   = 100.0-(100.0-drunk_traits_save02)*amount
	;LogTrace("alcohol = "+blood_alcohol+" effect = "+amount)
	;LogTrace("alcohol = "+blood_alcohol+" lively = "+HEXACO_eXtraversion)

	modifier = (FACET_Wilfulness+HEXACO_Openness+1.0)/100.0
	amount = 1.0-(2.0*blood_alcohol)/modifier
	FACET_Smartness  = drunk_traits_save08*amount
	;LogTrace("alcohol = "+blood_alcohol+" modifier = "+modifier+" effect = "+amount)
	;LogTrace("smart = "+FACET_Smartness)

	if blood_alcohol < 0.05 ; Almost sober
		; might feel the need for more
		drunk_level = 1
		IncreaseArousal(2.0,MOD_Daring)
		return
	endif
	
	modifier = (FACET_Toughness+HEXACO_Openness+1.0)/100.0
	amount = 1.0-(2.0*blood_alcohol)/modifier
	HEXACO_Emotionality   = 100.0-(100.0-drunk_traits_save01)*amount
	;LogTrace("alcohol = "+blood_alcohol+" modifier = "+modifier+" effect = "+amount)
	;LogTrace("anxious = "+HEXACO_Emotionality)

	modifier = (FACET_Wilfulness+HEXACO_Conscientiousness+1.0)/100.0
	amount = 1.0-(2.0*blood_alcohol)/modifier
	FACET_Boldness   = drunk_traits_save06*amount
	;LogTrace("alcohol = "+blood_alcohol+" modifier = "+modifier+" effect = "+amount)
	;LogTrace("bold = "+FACET_Boldness)

	if blood_alcohol < 0.12 ; Tipsy
		; feels euphoria boost to liveliness
		if __drunk_level != 2
			drunk_level = 2
			SendNotificationAbuse(name+" feels a bit tipsy")
		endif
		float mod = 15.0
		if actor_alias.has_blindfold
			mod = 10.0
		endif
		if !drunk_passedout && RandomFloat()*mod < MOD_Panic
			;LogTrace("TripAndFall MOD_Panic="+MOD_Panic)
			actor_alias.TripAndFall(2.0)
		endif
		IncreaseArousal(5.0,MOD_Daring)
		return
	endif
	
	modifier = (200.0-FACET_Submissivity-HEXACO_Honesty)/100.0
	amount = 1.0-(2.0*blood_alcohol)/modifier
	FACET_Toughness  = drunk_traits_save10*amount 
	;LogTrace("alcohol = "+blood_alcohol+" modifier = "+modifier+" effect = "+amount)
	;LogTrace("tough = "+FACET_Toughness)
	
	modifier = (200.0-FACET_Submissivity-HEXACO_Agreeableness)/100.0
	amount = 1.0-(2.0*blood_alcohol)/modifier
	FACET_Wilfulness    = drunk_traits_save07*amount  
	;LogTrace("alcohol = "+blood_alcohol+" modifier = "+modifier+" effect = "+amount)
	;LogTrace("wil = "+FACET_Wilfulness)
	
	if blood_alcohol < 0.25 ; Drunk
		; feels excitement, tired
		if __drunk_level != 3
			drunk_level = 3
			SendNotificationAbuse(name+" is drunk")
		endif
		float mod = 10.0
		if actor_alias.has_blindfold
			mod = 6.0
		endif
		if !drunk_passedout && RandomFloat()*mod < MOD_Panic
			actor_alias.TripAndFall(4.0)
		endif
		IncreaseArousal(2.0,MOD_Daring)
		return
	endif

	float chance_passout = MOD_Panic
	if blood_alcohol < 0.30 ; Smashed
		; feels confusion
		; emotional outburst (increase chance of shock), major loss of coordination, 
		;	insensitive to pain, confused, possible black out
		if __drunk_level != 4
			;LogTrace("is smashed "+__drunk_level)
			drunk_level = 4
			SendNotificationAbuse(name+" is smashed")
		endif
	else
		if __drunk_level < 5
			SendNotificationAbuse(name+" is about to pass out")
		endif
		if blood_alcohol < 0.40 ; Passed out
			; can pass out or choke on vomit
			chance_passout += 0.1
			drunk_level = 5
		elseif blood_alcohol < 0.45 ; Coma	
			chance_passout += 0.25
			drunk_level = 6
		else                        ; Death
			chance_passout += 0.5
			drunk_level = 7
		endif
	endif
	;LogTrace("Panic = "+MOD_Panic+" chance pass out = "+chance_passout+" level = "+__drunk_level)

	if actor_alias.canMove
		if drunk_passedout
			if !IsPassedOutNotDrunk() ; && RandomFloat() < MOD_Panic
				actor_alias.PushMeAway(0.0)
				SendNotificationAbuse(name+"'s head hits the ground")
				akRef.SetUnconscious()
			endif
		else	
			if RandomFloat() < chance_passout
				drunk_passedout = true
				actor_alias.Anim_IdleByString("DOMBaboDefeatKnockOutStart")
				wait(4.0)
				SendNotificationAbuse(name+" passed out!")
				actor_alias.Anim_IdleByString("DOMBaboDefeatKnockOutLoop")
			elseif RandomFloat()*5.0 < MOD_Panic
				actor_alias.TripAndFall(6.0)
			endif
		endif
	endif
EndFunction

Function HandleAlcoholOnUpdate()
	if blood_alcohol > 0.0 || __drunk_level > 0
		float current_time = GetCurrentGameTime()
		float elapsed_time = (current_time-blood_alcohol_time)*24.0
		float delta_time = blood_alcohol_last_time - blood_alcohol_time
		float used_blood_alcohol = 0.0
		if elapsed_time >= 4.0 ; Takes 2 to 8 hours to eliminate - We choose 4 hours
			used_blood_alcohol = blood_alcohol
			MakeSober()
		elseif akRef.Is3DLoaded() && delta_time > 0.0
			HandleAlcoholEffects()
			used_blood_alcohol =  blood_alcohol_start_level * delta_time /4.0
			blood_alcohol -= used_blood_alcohol
			if blood_alcohol < 0.0
				blood_alcohol = 0.0
				MakeSober()
			endif
			blood_alcohol_last_time = current_time
		endif	
		;SendNotificationAbuse(name+" blood alcohol level "+blood_alcohol+" / "+elapsed_time)
		;LogTrace("blood alcohol level "+blood_alcohol+" used="+used_blood_alcohol+" start="+blood_alcohol_start_level+" time="+elapsed_time+" delta="+delta_time+" start="+blood_alcohol_time)
	endif
	if intake_alcohol > 0.0
		float current_time = GetCurrentGameTime()
		float elapsed_time = (current_time-intake_alcohol_time)*24.0
		float delta_time = intake_alcohol_last_time - intake_alcohol_time
		float used_intake_alcohol = 0.0
		if elapsed_time >= 1.0 ; Takes roughly 1 hour to go into the blood completely
			blood_alcohol += intake_alcohol
			used_intake_alcohol = intake_alcohol
			intake_alcohol = 0.0
			intake_alcohol_time = 0.0
			intake_alcohol_last_time = 0.0
			intake_alcohol_start_level = 0.0
			blood_alcohol_time = current_time
			blood_alcohol_last_time = blood_alcohol_time
			blood_alcohol_start_level = blood_alcohol
		elseif akRef.Is3DLoaded() && delta_time > 0.0
			used_intake_alcohol = intake_alcohol_start_level * delta_time
			blood_alcohol += used_intake_alcohol
			intake_alcohol -= used_intake_alcohol
			if intake_alcohol < 0.0
				intake_alcohol = 0.0
			endif
			intake_alcohol_last_time = current_time
			blood_alcohol_time = current_time
			blood_alcohol_last_time = blood_alcohol_time
			blood_alcohol_start_level = blood_alcohol
		endif
		;SendNotificationAbuse(name+" intake alcohol level "+intake_alcohol+" / "+elapsed_time)
		;LogTrace("intake alcohol level "+intake_alcohol+" used="+used_intake_alcohol+" start="+intake_alcohol_start_level+" time="+elapsed_time+" delta="+delta_time+" start="+intake_alcohol_time)
	endif
EndFunction

; ### Personamity Traits following HEXACO model ###

Float __HEXACO_Honesty = 50.0
Float Property BASE_Honesty = -1.0 Auto Hidden
Float Property HEXACO_Honesty Hidden
	Float Function get()
		return __HEXACO_Honesty
	EndFunction
	Function set(Float value)
		if __HEXACO_Honesty == value
			;LogTrace("HEXACO_Honesty value is unchanged "+value+" "+__HEXACO_Honesty)
			return
		endif
		__HEXACO_Honesty = value
		;LogTrace("HEXACO_Honesty value has changed "+value+" "+__HEXACO_Honesty)
		if __HEXACO_Honesty > 100.0
			__HEXACO_Honesty = 100.0
		elseif __HEXACO_Honesty < 0.0
			__HEXACO_Honesty = 0.0
		endif
		if BASE_Honesty < 0
			BASE_Honesty = value
		elseif __HEXACO_Honesty > BASE_Honesty + DOM01.trait_variation
			__HEXACO_Honesty = BASE_Honesty + DOM01.trait_variation
		elseif __HEXACO_Honesty < BASE_Honesty - DOM01.trait_variation
			__HEXACO_Honesty = BASE_Honesty - DOM01.trait_variation
		endif
		akRef.SetFactionRank(DOM01.DOMTraitHonesty, __HEXACO_Honesty as Int)

		RegisterForUpdatePersonalityIndex()

		MOD_Humility = GetDefaultModifierHumility(1.0)		
		MOD_Sincerity = GetDefaultModifierSincerity(1.0)
		MOD_Modesty = GetDefaultModifierModesty(1.0)
		MOD_Insensitivity = getDefaultModifierInsensitivity(1.0)
		MOD_Greed = GetDefaultModifierGreed(1.0)
		MOD_Criminality = getDefaultModifierCriminality(1.0)
		MOD_Vaginal = GetDefaultModifierVaginal(1.0)
		MOD_Addict = GetDefaultModifierAddict(1.0)	

		MOD_Intimidate = GetDefaultModifierIntimidate(1.0)
		MOD_SelfEsteem = GetDefaultModifierSelfEsteem(1.0)
		MOD_Gentleness = GetDefaultModifierGentleness(1.0)
		MOD_Controller = GetDefaultModifierController(1.0)
		MOD_Pretender = GetDefaultModifierPretender(1.0)

		MOD_SumAll = GetDefaultModifiersSum()
		CheckPotentialSlaverFaction()
		
		actor_alias.SendExternalEventSSF("HEXACOChange","Honesty",__HEXACO_Honesty)
		;LogTrace("HEXACO_Honesty value was changed "+value+" "+__HEXACO_Honesty)
	EndFunction ; 10 modifiers
EndProperty

Float __HEXACO_Emotionality = 50.0
Float Property BASE_Emotionality = -1.0 Auto Hidden
Float Property HEXACO_Emotionality Hidden
	Float Function get()
		return __HEXACO_Emotionality
	EndFunction
	Function set(Float value)
		if __HEXACO_Emotionality == value
			return
		endif
		__HEXACO_Emotionality = value
		if __HEXACO_Emotionality > 100.0
			__HEXACO_Emotionality = 100.0
		elseif __HEXACO_Emotionality < 0.0
			__HEXACO_Emotionality = 0.0
		endif
		if BASE_Emotionality < 0
			BASE_Emotionality = value
		elseif __HEXACO_Emotionality > BASE_Emotionality + DOM01.trait_variation
			__HEXACO_Emotionality = BASE_Emotionality + DOM01.trait_variation
		elseif __HEXACO_Emotionality < BASE_Emotionality - DOM01.trait_variation
			__HEXACO_Emotionality = BASE_Emotionality - DOM01.trait_variation
		endif
		akRef.SetFactionRank(DOM01.DOMTraitEmotionality, __HEXACO_Emotionality as Int)
		
		RegisterForUpdatePersonalityIndex()

		MOD_Panic = GetDefaultModifierPanic(1.0)
		MOD_Fearfulness = GetDefaultModifierFearfulness(1.0)
		MOD_Sentimentality = GetDefaultModifierSentimentality(1.0)
		MOD_Impressionable = GetDefaultModifierImpressionable(1.0)
		MOD_Dependence = GetDefaultModifierDependence(1.0)
		MOD_Anxiety = GetDefaultModifierAnxiety(1.0)
		MOD_Intimidate = GetDefaultModifierIntimidate(1.0)

		MOD_Modesty = GetDefaultModifierModesty(1.0)
		MOD_Ingenuity = GetDefaultModifierIngenuity(1.0)
		MOD_Forgiveness = getDefaultModiferForgiveness(1.0)
		MOD_Consideration = GetDefaultModifierConsideration(1.0)
		MOD_Manipulation = GetDefaultModifierManipulation(1.0)
		
		MOD_SumAll = GetDefaultModifiersSum()

		actor_alias.SendExternalEventSSF("HEXACOChange","Emotionality",__HEXACO_Emotionality)
	EndFunction ; 10 modifiers
EndProperty

Float __HEXACO_eXtraversion = 50.0
Float Property BASE_Extraversion = -1.0 Auto Hidden
Float Property HEXACO_eXtraversion Hidden
	Float Function get()
		return __HEXACO_eXtraversion
	EndFunction
	Function set(Float value)
		if __HEXACO_eXtraversion == value
			return
		endif
		__HEXACO_eXtraversion = value
		if __HEXACO_eXtraversion > 100.0
			__HEXACO_eXtraversion = 100.0
		elseif __HEXACO_eXtraversion < 0.0
			__HEXACO_eXtraversion = 0.0
		endif
		if BASE_Extraversion < 0
			BASE_Extraversion = value
		elseif __HEXACO_eXtraversion > BASE_Extraversion + DOM01.trait_variation
			__HEXACO_eXtraversion = BASE_Extraversion + DOM01.trait_variation
		elseif __HEXACO_eXtraversion < BASE_Extraversion - DOM01.trait_variation
			__HEXACO_eXtraversion = BASE_Extraversion - DOM01.trait_variation
		endif
		akRef.SetFactionRank(DOM01.DOMTraitExtraversion, __HEXACO_eXtraversion as Int)
		
		RegisterForUpdatePersonalityIndex()

		MOD_Liveliness = GetDefaultModifierLively(1.0)
		MOD_SelfEsteem = GetDefaultModifierSelfEsteem(1.0)
		MOD_Naivety = GetDefaultModifierNaivety(1.0)	
		MOD_Sociability = GetDefaultModifierSociability(1.0)
		MOD_Daring = GetDefaultModifierDaring(1.0)
		MOD_Ingenuity = GetDefaultModifierIngenuity(1.0)
		MOD_Oral = GetDefaultModifierOral(1.0)

		MOD_Insensitivity = getDefaultModifierInsensitivity(1.0)
		MOD_Fearfulness = GetDefaultModifierFearfulness(1.0)
		MOD_Impatience = getDefaultModifierImpatience(1.0)
		MOD_Perfectionism = GetDefaultModifierPerfectionism(1.0)
		MOD_Discipline = GetDefaultModifierDiscipline(1.0)

		MOD_SumAll = GetDefaultModifiersSum()

		actor_alias.SendExternalEventSSF("HEXACOChange","Extraversion",__HEXACO_eXtraversion)
	EndFunction ; 11 modifiers
EndProperty

Float __HEXACO_Agreeableness = 50.0
Float Property BASE_Agreeableness = -1.0 Auto Hidden
Float Property HEXACO_Agreeableness Hidden
	Float Function get()
		return __HEXACO_Agreeableness
	EndFunction
	Function set(Float value)
		if __HEXACO_Agreeableness == value
			return
		endif
		__HEXACO_Agreeableness = value
		if __HEXACO_Agreeableness > 100.0
			__HEXACO_Agreeableness = 100.0
		elseif __HEXACO_Agreeableness < 0.0
			__HEXACO_Agreeableness = 0.0
		endif
		if BASE_Agreeableness < 0
			BASE_Agreeableness = value
		elseif __HEXACO_Agreeableness > BASE_Agreeableness + DOM01.trait_variation
			__HEXACO_Agreeableness = BASE_Agreeableness + DOM01.trait_variation
		elseif __HEXACO_Agreeableness < BASE_Agreeableness - DOM01.trait_variation
			__HEXACO_Agreeableness = BASE_Agreeableness - DOM01.trait_variation
		endif
		akRef.SetFactionRank(DOM01.DOMTraitAgreeableness, __HEXACO_Agreeableness as Int)
		
		RegisterForUpdatePersonalityIndex()

		MOD_Gentleness = GetDefaultModifierGentleness(1.0)
		MOD_Impatience = getDefaultModifierImpatience(1.0)
		MOD_Hope = GetDefaultModifierHope(1.0)
		MOD_Forgiveness = getDefaultModiferForgiveness(1.0)
		MOD_Empathy = GetDefaultModifierEmpathy(1.0)
		MOD_Resentment = GetDefaultModifierResentment(1.0)
		MOD_Anal = GetDefaultModifierAnal(1.0)
		MOD_Addict = GetDefaultModifierAddict(1.0)	

		MOD_Sincerity = GetDefaultModifierSincerity(1.0)
		MOD_Dependence = GetDefaultModifierDependence(1.0)
		MOD_Liveliness = GetDefaultModifierLively(1.0)
		MOD_Prudent = GetDefaultModifierPrudent(1.0)
		MOD_Flexibility = GetDefaultModifierFlexibility(1.0)
		
		MOD_SumAll = GetDefaultModifiersSum()

		actor_alias.SendExternalEventSSF("HEXACOChange","Agreeableness",__HEXACO_Agreeableness)
	EndFunction ; 11 modifiers
EndProperty

Float __HEXACO_Conscientiousness = 50.0
Float Property BASE_Conscientiousness = -1.0 Auto Hidden
Float Property HEXACO_Conscientiousness Hidden
	Float Function get()
		return __HEXACO_Conscientiousness
	EndFunction
	Function set(Float value)
		if __HEXACO_Conscientiousness == value
			return
		endif
		__HEXACO_Conscientiousness = value
		if __HEXACO_Conscientiousness > 100.0
			__HEXACO_Conscientiousness = 100.0
		elseif __HEXACO_Conscientiousness < 0.0
			__HEXACO_Conscientiousness = 0.0
		endif
		if BASE_Conscientiousness < 0
			BASE_Conscientiousness = value
		elseif __HEXACO_Conscientiousness > BASE_Conscientiousness + DOM01.trait_variation
			__HEXACO_Conscientiousness = BASE_Conscientiousness + DOM01.trait_variation
		elseif __HEXACO_Conscientiousness < BASE_Conscientiousness - DOM01.trait_variation
			__HEXACO_Conscientiousness = BASE_Conscientiousness - DOM01.trait_variation
		endif
		akRef.SetFactionRank(DOM01.DOMTraitConscientiousness, __HEXACO_Conscientiousness as Int)
		
		RegisterForUpdatePersonalityIndex()

		MOD_Laborious = GetDefaultModifierLaborious(1.0)
		MOD_Diligent = GetDefaultModifierDiligent(1.0)
		MOD_Consideration = GetDefaultModifierConsideration(1.0)
		MOD_Perfectionism = GetDefaultModifierPerfectionism(1.0)
		MOD_Prudent = GetDefaultModifierPrudent(1.0)	
		MOD_Organized = GetDefaultModifierOrganized(1.0)
		MOD_Controller = GetDefaultModifierController(1.0)

		MOD_Greed = GetDefaultModifierGreed(1.0)
		MOD_Anxiety = GetDefaultModifierAnxiety(1.0)
		MOD_Oral = GetDefaultModifierOral(1.0)
		MOD_Addict = GetDefaultModifierAddict(1.0)	
		MOD_Resentment = GetDefaultModifierResentment(1.0)
		MOD_Authority = GetDefaultModifierAuthority(1.0)

		MOD_SumAll = GetDefaultModifiersSum()

		actor_alias.SendExternalEventSSF("HEXACOChange","Conscientiousness",__HEXACO_Conscientiousness)
	EndFunction ; 10 modifiers
EndProperty

Float __HEXACO_Openness = 50.0
Float Property BASE_Openness = -1.0 Auto Hidden
Float Property HEXACO_Openness Hidden
	Float Function get()
		return __HEXACO_Openness
	EndFunction
	Function set(Float value)
		if __HEXACO_Openness == value
			return
		endif
		__HEXACO_Openness = value
		if __HEXACO_Openness > 100.0
			__HEXACO_Openness = 100.0
		elseif __HEXACO_Openness < 0.0
			__HEXACO_Openness = 0.0
		endif
		if BASE_Openness < 0
			BASE_Openness = value
		elseif __HEXACO_Openness > BASE_Openness + DOM01.trait_variation
			__HEXACO_Openness = BASE_Openness + DOM01.trait_variation
		elseif __HEXACO_Openness < BASE_Openness - DOM01.trait_variation
			__HEXACO_Openness = BASE_Openness - DOM01.trait_variation
		endif
		akRef.SetFactionRank(DOM01.DOMTraitOpenness, __HEXACO_Openness as Int)
		
		RegisterForUpdatePersonalityIndex()

		MOD_Authority = GetDefaultModifierAuthority(1.0)
		MOD_Rebellion = GetDefaultModifierRebellion(1.0)
		MOD_Flexibility = GetDefaultModifierFlexibility(1.0)
		MOD_Manipulation = GetDefaultModifierManipulation(1.0)
		MOD_Creativity = GetDefaultModifierCreativity(1.0)
		MOD_Discipline = GetDefaultModifierDiscipline(1.0)	
		MOD_Pretender = GetDefaultModifierPretender(1.0)

		MOD_Criminality = getDefaultModifierCriminality(1.0)
		MOD_Impressionable = GetDefaultModifierImpressionable(1.0)
		MOD_Naivety = GetDefaultModifierNaivety(1.0)
		MOD_Anal = GetDefaultModifierAnal(1.0)	
		MOD_Organized = GetDefaultModifierOrganized(1.0)
		
		MOD_SumAll = GetDefaultModifiersSum()

		actor_alias.SendExternalEventSSF("HEXACOChange","Openness",__HEXACO_Openness)
	EndFunction ; 10 modifiers
EndProperty

; ### Personality Facets acting as directions for HEXACO traits
; See https://hexaco.org/scaledescriptions

Float __FACET_Wilfulness = 50.0
Float Property BASE_Wilfulness = -1.0 Auto Hidden
Float Property FACET_Wilfulness Hidden
	Float Function get()
		return __FACET_Wilfulness
	EndFunction
	Function set(Float value)
		if __FACET_Wilfulness == value
			return
		endif
		__FACET_Wilfulness = value
		if __FACET_Wilfulness > 100.0
			__FACET_Wilfulness = 100.0
		elseif __FACET_Wilfulness < 0.0
			__FACET_Wilfulness = 0.0
		endif
		if BASE_Wilfulness < 0
			BASE_Wilfulness = value
		elseif __FACET_Wilfulness > BASE_Wilfulness + DOM01.trait_variation
			__FACET_Wilfulness = BASE_Wilfulness + DOM01.trait_variation
		elseif __FACET_Wilfulness < BASE_Wilfulness - DOM01.trait_variation
			__FACET_Wilfulness = BASE_Wilfulness - DOM01.trait_variation
		endif
		akRef.SetFactionRank(DOM01.DOMFacetWilfulness, __FACET_Wilfulness as Int)
		
		RegisterForUpdatePersonalityIndex()

		MOD_Humility = GetDefaultModifierHumility(1.0)
		MOD_Panic = GetDefaultModifierPanic(1.0)
		MOD_Liveliness = GetDefaultModifierLively(1.0)
		MOD_Gentleness = GetDefaultModifierGentleness(1.0)
		MOD_Laborious = GetDefaultModifierLaborious(1.0)
		MOD_Authority = GetDefaultModifierAuthority(1.0)

		MOD_Vaginal = GetDefaultModifierVaginal(1.0)
		MOD_Hope = GetDefaultModifierHope(1.0)		
		MOD_Anal = GetDefaultModifierAnal(1.0)
		MOD_Rebellion = GetDefaultModifierRebellion(1.0)
		MOD_Combat   = getDefaultModifierCombat(1.0)

		MOD_SumAll = GetDefaultModifiersSum()

		actor_alias.SendExternalEventSSF("FACETChange","Wilfulness",__FACET_Wilfulness)
	EndFunction ; 9 modifiers
EndProperty

Float __FACET_Toughness = 50.0
Float Property BASE_Toughness = -1.0 Auto Hidden
Float Property FACET_Toughness Hidden
	Float Function get()
		return __FACET_Toughness
	EndFunction
	Function set(Float value)
		if __FACET_Toughness == value
			return
		endif
		__FACET_Toughness = value
		if __FACET_Toughness > 100.0
			__FACET_Toughness = 100.0
		elseif __FACET_Toughness < 0.0
			__FACET_Toughness = 0.0
		endif
		if BASE_Toughness < 0
			BASE_Toughness = value
		elseif __FACET_Toughness > BASE_Toughness + DOM01.trait_variation
			__FACET_Toughness = BASE_Toughness + DOM01.trait_variation
		elseif __FACET_Toughness < BASE_Toughness - DOM01.trait_variation
			__FACET_Toughness = BASE_Toughness - DOM01.trait_variation
		endif
		akRef.SetFactionRank(DOM01.DOMFacetToughness, __FACET_Toughness as Int)
		
		RegisterForUpdatePersonalityIndex()

		MOD_Sincerity = GetDefaultModifierSincerity(1.0)
		MOD_Fearfulness = GetDefaultModifierFearfulness(1.0)	
		MOD_SelfEsteem = GetDefaultModifierSelfEsteem(1.0)
		MOD_Impatience = getDefaultModifierImpatience(1.0)
		MOD_Diligent = GetDefaultModifierDiligent(1.0)
		MOD_Rebellion = GetDefaultModifierRebellion(1.0)
		
		MOD_Humility = GetDefaultModifierHumility(1.0)
		MOD_Intimidate = GetDefaultModifierIntimidate(1.0)
		MOD_Daring = GetDefaultModifierDaring(1.0)
		MOD_Orgasm = getDefaultModifierOrgasm(1.0)	
		
		MOD_SumAll = GetDefaultModifiersSum()

		actor_alias.SendExternalEventSSF("FACETChange","Toughness",__FACET_Toughness)
	EndFunction ; 10 modifiers
EndProperty

Float __FACET_Sensuality = 50.0
Float Property BASE_Sensuality = -1.0 Auto Hidden
Float Property FACET_Sensuality Hidden
	Float Function get()
		return __FACET_Sensuality
	EndFunction
	Function set(Float value)
		if __FACET_Sensuality == value
			return
		endif
		__FACET_Sensuality = value
		if __FACET_Sensuality > 100.0
			__FACET_Sensuality = 100.0
		elseif __FACET_Sensuality < 0.0
			__FACET_Sensuality = 0.0
		endif
		if BASE_Sensuality < 0
			BASE_Sensuality = value
		elseif __FACET_Sensuality > BASE_Sensuality + DOM01.trait_variation
			__FACET_Sensuality = BASE_Sensuality + DOM01.trait_variation
		elseif __FACET_Sensuality < BASE_Sensuality - DOM01.trait_variation
			__FACET_Sensuality = BASE_Sensuality - DOM01.trait_variation
		endif
		akRef.SetFactionRank(DOM01.DOMFacetSensuality, __FACET_Sensuality as Int)
		
		RegisterForUpdatePersonalityIndex()

		MOD_Modesty = GetDefaultModifierModesty(1.0)
		MOD_Sentimentality = GetDefaultModifierSentimentality(1.0)
		MOD_Naivety = GetDefaultModifierNaivety(1.0)	
		MOD_Hope = GetDefaultModifierHope(1.0)
		MOD_Consideration = GetDefaultModifierConsideration(1.0)
		MOD_Flexibility = GetDefaultModifierFlexibility(1.0)

		MOD_Vaginal = GetDefaultModifierVaginal(1.0)	
		MOD_Oral = GetDefaultModifierOral(1.0)
		MOD_Empathy = GetDefaultModifierEmpathy(1.0)
		MOD_Creativity = GetDefaultModifierCreativity(1.0)
		MOD_Orgasm = getDefaultModifierOrgasm(1.0)
		
		MOD_SumAll = GetDefaultModifiersSum()

		actor_alias.SendExternalEventSSF("FACETChange","Sensuality",__FACET_Sensuality)
	EndFunction ; 10 modifiers
EndProperty

Float __FACET_Submissivity = 50.0
Float Property BASE_Submissivity = -1.0 Auto Hidden
Float Property FACET_Submissivity Hidden
	Float Function get()
		return __FACET_Submissivity
	EndFunction
	Function set(Float value)
		if __FACET_Submissivity == value
			return
		endif
		__FACET_Submissivity = value
		if __FACET_Submissivity > 100.0
			__FACET_Submissivity = 100.0
		elseif __FACET_Submissivity < 0.0
			__FACET_Submissivity = 0.0
		endif
		if BASE_Submissivity < 0
			BASE_Submissivity = value
		elseif __FACET_Submissivity > BASE_Submissivity + DOM01.trait_variation
			__FACET_Submissivity = BASE_Submissivity + DOM01.trait_variation
		elseif __FACET_Submissivity < BASE_Submissivity - DOM01.trait_variation
			__FACET_Submissivity = BASE_Submissivity - DOM01.trait_variation
		endif
		akRef.SetFactionRank(DOM01.DOMFacetSubmissivity, __FACET_Submissivity as Int)
		
		RegisterForUpdatePersonalityIndex()

		MOD_Insensitivity = getDefaultModifierInsensitivity(1.0)
		MOD_Impressionable = GetDefaultModifierImpressionable(1.0)
		MOD_Sociability = GetDefaultModifierSociability(1.0)
		MOD_Forgiveness = getDefaultModiferForgiveness(1.0)
		MOD_Perfectionism = GetDefaultModifierPerfectionism(1.0)
		MOD_Manipulation = GetDefaultModifierManipulation(1.0)

		MOD_Vaginal = GetDefaultModifierVaginal(1.0)		
		MOD_Oral = GetDefaultModifierOral(1.0)
        MOD_Anal = GetDefaultModifierAnal(1.0)
        MOD_Diligent = GetDefaultModifierDiligent(1.0)	
		MOD_Controller = GetDefaultModifierController(1.0)
		
 		MOD_SumAll = GetDefaultModifiersSum()

		actor_alias.SendExternalEventSSF("FACETChange","Submissivity",__FACET_Submissivity)
	EndFunction ; 10 modifiers
EndProperty

Float __FACET_Boldness = 50.0
Float Property BASE_Boldness = -1.0 Auto Hidden
Float Property FACET_Boldness Hidden
	Float Function get()
		return __FACET_Boldness
	EndFunction
	Function set(Float value)
		if __FACET_Boldness == value
			return
		endif
		__FACET_Boldness = value
		if __FACET_Boldness > 100.0
			__FACET_Boldness = 100.0
		elseif __FACET_Boldness < 0.0
			__FACET_Boldness = 0.0
		endif
		if BASE_Boldness < 0
			BASE_Boldness = value
		elseif __FACET_Boldness > BASE_Boldness + DOM01.trait_variation
			__FACET_Boldness = BASE_Boldness + DOM01.trait_variation
		elseif __FACET_Boldness < BASE_Boldness - DOM01.trait_variation
			__FACET_Boldness = BASE_Boldness - DOM01.trait_variation
		endif
		akRef.SetFactionRank(DOM01.DOMFacetBoldness, __FACET_Boldness as Int)
		
		RegisterForUpdatePersonalityIndex()

		MOD_Greed = GetDefaultModifierGreed(1.0)
		MOD_Dependence = GetDefaultModifierDependence(1.0)
		MOD_Daring = GetDefaultModifierDaring(1.0)
		MOD_Empathy = GetDefaultModifierEmpathy(1.0)
		MOD_Prudent = GetDefaultModifierPrudent(1.0)	
		MOD_Creativity = GetDefaultModifierCreativity(1.0)
		
		MOD_Panic = GetDefaultModifierPanic(1.0)
		MOD_Sociability = GetDefaultModifierSociability(1.0)
		MOD_Orgasm = getDefaultModifierOrgasm(1.0)
		MOD_Combat   = getDefaultModifierCombat(1.0)
		
		MOD_SumAll = GetDefaultModifiersSum()

		actor_alias.SendExternalEventSSF("FACETChange","Boldness",__FACET_Boldness)
	EndFunction ; 7 modifiers
EndProperty

Float __FACET_Smartness = 50.0
Float Property BASE_Smartness = -1.0 Auto Hidden
Float Property FACET_Smartness Hidden
	Float Function get()
		return __FACET_Smartness
	EndFunction
	Function set(Float value)
		if __FACET_Smartness == value
			return
		endif
		__FACET_Smartness = value
		if __FACET_Smartness > 100.0
			__FACET_Smartness = 100.0
		elseif __FACET_Smartness < 0.0
			__FACET_Smartness = 0.0
		endif
		if BASE_Smartness < 0
			BASE_Smartness = value
		elseif __FACET_Smartness > BASE_Smartness + DOM01.trait_variation
			__FACET_Smartness = BASE_Smartness + DOM01.trait_variation
		elseif __FACET_Smartness < BASE_Smartness - DOM01.trait_variation
			__FACET_Smartness = BASE_Smartness - DOM01.trait_variation
		endif
		akRef.SetFactionRank(DOM01.DOMFacetSmartness, __FACET_Smartness as Int)
		
		RegisterForUpdatePersonalityIndex()

		MOD_Criminality = getDefaultModifierCriminality(1.0)
		MOD_Anxiety = GetDefaultModifierAnxiety(1.0)
		MOD_Ingenuity = GetDefaultModifierIngenuity(1.0)
		MOD_Resentment = GetDefaultModifierResentment(1.0)
		MOD_Organized = GetDefaultModifierOrganized(1.0)
		MOD_Discipline = GetDefaultModifierDiscipline(1.0)	

		MOD_Sentimentality = GetDefaultModifierSentimentality(1.0)
		MOD_Laborious = GetDefaultModifierLaborious(1.0)
		MOD_Pretender = GetDefaultModifierPretender(1.0)
		MOD_Combat   = getDefaultModifierCombat(1.0)
		
		MOD_SumAll = GetDefaultModifiersSum()

		actor_alias.SendExternalEventSSF("FACETChange","Smartness",__FACET_Smartness)
	EndFunction ; 8 modifiers
EndProperty

; Emotion modifiers according to personality traits and facets

; -=TAK=- Sum of 6 main emotion modifiers

Float __MOD_SumAll = 3.0
Float Property MOD_SumAll Hidden
	Float Function get()
		return __MOD_SumAll
	EndFunction
	Function set(Float value)
		__MOD_SumAll = value
	EndFunction
EndProperty
float Function GetDefaultModifiersSum() ; Used by choose topic and idles
	float mod = MOD_Humility+MOD_Fearfulness+MOD_Naivety+MOD_Forgiveness+MOD_Prudent+MOD_Discipline
	return mod
EndFunction

; -=TAK=- Modifiers - 6 per HEXACO trait
; Some have no need for factions as they are only used internally

; --- Honesty related

Float __MOD_Humility = 0.5 ; Used for submission training efficiency
Float Property MOD_Humility Hidden
	Float Function get()
		return __MOD_Humility
	EndFunction
	Function set(Float value)
		if __MOD_Humility == value
			return
		endif
		__MOD_Humility = value
		SetModifierFromFaction(akRef,DOM01.DOMModHumility, (__MOD_Humility) )
		; Update dependencies
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceCrushed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceInsecure()
	EndFunction
EndProperty
float Function GetDefaultModifierHumility(float w) ; Used by submission and anal training for humiliation
	; emotion = Pain, traits = +honest -wil -tough 
	float mod = HEXACO_Honesty*3.0+(100.0-FACET_Wilfulness)*2.0+(100.0-FACET_Toughness)
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Sincerity = 0.5 ; Used for response to trauma
Float Property MOD_Sincerity Hidden
	Float Function get()
		return __MOD_Sincerity
	EndFunction
	Function set(Float value)
		__MOD_Sincerity = value
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty
float Function GetDefaultModifierSincerity(float w) ; Used by PTSD amount of shock
	; emotion = Trauma, +honesty -tough +kind
	float mod = HEXACO_Honesty*3.0+(100.0-FACET_Toughness)*2.0+HEXACO_Agreeableness
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Modesty = 0.5 ; Used for cooldown time
Float Property MOD_Modesty Hidden
	Float Function get()
		return __MOD_Modesty
	EndFunction
	Function set(Float value)
		if __MOD_Modesty == value
			return
		endif
		__MOD_Modesty = value
		SetModifierFromFaction(akRef,DOM01.DOMModModesty, (__MOD_Modesty) )
		; Update dependencies
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceRecoverFromAngry()
		RegisterForUpdateChanceRecoverFromShock()
		RegisterForUpdateChanceRecoverFromSad()
		RegisterForUpdateChanceRecoverFromAshamed()
		RegisterForUpdateChanceRecoverFromDepressed()
		RegisterForUpdateChanceRecoverFromJealous()
		RegisterForUpdateChanceRecoverFromInsecure()
	EndFunction
EndProperty
float Function GetDefaultModifierModesty(float w) ; Used by sad, inlove, loyal, freedom
	; emotion = calm, traits = +honesty +sensual -anxious
	float mod = HEXACO_Honesty*3.0+FACET_Sensuality*2.0+(100.0-HEXACO_Emotionality)  
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Insensitivity = 0.5 ; Used for trainers efficiency
Float Property MOD_Insensitivity Hidden
	Float Function get()
		return __MOD_Insensitivity
	EndFunction
	Function set(Float value)
		__MOD_Insensitivity = value
		SetModifierFromFaction(akRef,DOM01.DOMModInsensitivity, (__MOD_Insensitivity) )
		RegisterForUpdateChanceHappy()
	EndFunction
EndProperty
float Function getDefaultModifierInsensitivity(float w)
    ; -subm -honest +live
	float mod = (100.0-FACET_Submissivity)*2.0+(100.0-HEXACO_Honesty)*3.0+HEXACO_eXtraversion
	return NormModifier(mod)*w
EndFunction

Float __MOD_Greed = 0.5 ; Used for gifts
Float Property MOD_Greed Hidden
	Float Function get()
		return __MOD_Greed
	EndFunction
	Function set(Float value)
		__MOD_Greed = value
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty
float Function GetDefaultModifierGreed(float w) ; Used by sad, inlove, loyal, freedom
	; emotion = calm, traits = -honesty -bold -cons
	float mod = (100.0-HEXACO_Honesty)*3.0+(100.0-FACET_Boldness)*2.0+(100.0-HEXACO_Conscientiousness)  
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Criminality = 0.5 ; Used for housemaster efficiencies
Float Property MOD_Criminality Hidden
	Float Function get()
		return __MOD_Criminality
	EndFunction
	Function set(Float value)
		__MOD_Criminality = value
		SetModifierFromFaction(akRef,DOM01.DOMModCriminality, (__MOD_Criminality) )
		RegisterForUpdateChanceHappy()
	EndFunction
EndProperty
Float Function getDefaultModifierCriminality(float w)
	; -honest -open +smart
	float mod = (100.0-HEXACO_Honesty)*3.0+(100.0-HEXACO_Openness)+FACET_Smartness*2.0
	return NormModifier(mod)*w
EndFunction

; --- Emotionality related

Float __MOD_Panic = 0.5 ; Used when slave is running away for chance to trip
Float Property MOD_Panic Hidden
	Float Function get()
		return __MOD_Panic
	EndFunction
	Function set(Float value)
		if __MOD_Panic == value
			return
		endif
		__MOD_Panic = value
		; Update dependencies
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceDepressed()
	EndFunction
EndProperty
float Function GetDefaultModifierPanic(float w) ; Used by tripping (running away) and passing out (drunk)
	; emotion = Fear traits = -bold -wil +anxious 
	float mod = (100.0-FACET_Boldness)+(100.0-FACET_Wilfulness)*2.0+HEXACO_Emotionality*3.0
	return NormModifier(mod)*w
EndFunction

Float __MOD_Fearfulness = 0.5 ; Used for fear training efficiency
Float Property MOD_Fearfulness Hidden
	Float Function get()
		return __MOD_Fearfulness
	EndFunction
	Function set(Float value)
		if __MOD_Fearfulness == value
			return
		endif
		__MOD_Fearfulness = value
		SetModifierFromFaction(akRef,DOM01.DOMModFearfulness, (__MOD_Fearfulness) )
		; Update dependencies
		RegisterForUpdateChanceRunAway()
		RegisterForUpdateChanceRunAwayGang()
		RegisterForUpdateChanceAfraid()
		RegisterForUpdateChanceScared()
		RegisterForUpdateChanceTerrified()
	EndFunction
EndProperty
float Function GetDefaultModifierFearfulness(float w) ; Used by fear training and no sex for submission
	; emotion = Fear traits = +anxious -tough +lively 
	float mod = HEXACO_Emotionality*3.0+(100.0-FACET_Toughness)*2.0+HEXACO_eXtraversion
	return NormModifier(mod)*w
EndFunction

Float __MOD_Sentimentality = 0.5 ; Used for inlove mood chance
Float Property MOD_Sentimentality Hidden
	Float Function get()
		return __MOD_Sentimentality
	EndFunction
	Function set(Float value)
		if __MOD_Sentimentality == value
			return
		endif
		__MOD_Sentimentality = value
		SetModifierFromFaction(akRef,DOM01.DOMModSentimentality, (__MOD_Sentimentality) )
		; Update dependencies
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty
float Function GetDefaultModifierSentimentality(float w) ; Used by inlove mood
	; emotion = Love, traits = +smart +anxious +sens
	float mod = FACET_Smartness+FACET_Sensuality*2.0+HEXACO_Emotionality*3.0  
	return NormModifier(mod)*w
EndFunction

Float __MOD_Impressionable = 0.5 ; Used for good times efficiency
Float Property MOD_Impressionable Hidden
	Float Function get()
		return __MOD_Impressionable
	EndFunction
	Function set(Float value)
		if __MOD_Impressionable == value
			return
		endif
		__MOD_Impressionable = value
		; Update dependencies
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty
float Function GetDefaultModifierImpressionable(float w) ; Used by inlove, loyal mood
	; emotion = Joy, traits = +anxious -open +subm
	float mod = HEXACO_Emotionality*3.0+(100.0-HEXACO_Openness)+FACET_Submissivity*2.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Intimidate = 0.5 ; Used by persuader skill
Float Property MOD_Intimidate Hidden
	Float Function get()
		return __MOD_Intimidate
	EndFunction
	Function set(Float value)
		if __MOD_Intimidate == value
			return
		endif
		__MOD_Intimidate = value
		SetModifierFromFaction(akRef,DOM01.DOMModIntimidate, (__MOD_Intimidate) )
		; Update dependencies
	EndFunction
EndProperty
float Function GetDefaultModifierIntimidate(float w) ; Used by depressed mood
	; emotion = frighten others, traits = +anxious +tough -honest
	float mod = HEXACO_Emotionality*2.0+FACET_Toughness*2.0+(100.0-HEXACO_Honesty)*2.0
	return NormModifier(mod)*w
EndFunction

Float __MOD_Dependence = 0.5 ; Used by jealous mood
Float Property MOD_Dependence Hidden
	Float Function get()
		return __MOD_Dependence
	EndFunction
	Function set(Float value)
		if __MOD_Dependence == value
			return
		endif
		__MOD_Dependence = value
		SetModifierFromFaction(akRef,DOM01.DOMModDependence, (__MOD_Dependence) )
		; Update dependencies
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceJealous()
		RegisterForUpdateChanceInsecure()
		RegisterForUpdateChanceCharmed()
	EndFunction
EndProperty
float Function GetDefaultModifierDependence(float w) ; Used by depressed mood
	; emotion = jealousy, traits = +anxious -bold +kind
	float mod = HEXACO_Emotionality*3.0+(100.0-FACET_Boldness)*2.0+HEXACO_Agreeableness
	return NormModifier(mod)*w
EndFunction

Float __MOD_Anxiety = 0.5
Float Property MOD_Anxiety Hidden
	Float Function get()
		return __MOD_Anxiety
	EndFunction
	Function set(Float value)
		__MOD_Anxiety = value

		; Update dependencies
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceCrushed()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceJealous()
	EndFunction
EndProperty
float Function GetDefaultModifierAnxiety(float w) ; Used by PTSD chance of shock
	; emotion = Distress,  +anxious +smart +cons
	float mod = HEXACO_Emotionality*3.0+FACET_Smartness*2.0+HEXACO_Conscientiousness
	return NormModifier(mod)*w	
EndFunction

; --- eXtraversion related

Float __MOD_Liveliness = 0.5
Float Property MOD_Liveliness Hidden
	Float Function get()
		return __MOD_Liveliness
	EndFunction
	Function set(Float value)
		if __MOD_Liveliness == value
			return
		endif
		__MOD_Liveliness = value
		; Update dependencies
		RegisterForUpdateChanceDepressed()
	EndFunction
EndProperty
float Function GetDefaultModifierLively(float w) ; 
	; emotion = Energy, traits = -wil + kind +live
	float mod =HEXACO_Agreeableness+(100.0-FACET_Wilfulness)*2.0+HEXACO_eXtraversion*3.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_SelfEsteem = 0.5
Float Property MOD_SelfEsteem Hidden
	Float Function get()
		return __MOD_SelfEsteem
	EndFunction
	Function set(Float value)
		if __MOD_SelfEsteem == value
			return
		endif
		__MOD_SelfEsteem = value
		SetModifierFromFaction(akRef,DOM01.DOMModSelfEsteem, (__MOD_SelfEsteem) )
		; Update dependencies
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceCrushed()
		RegisterForUpdateChanceDepressed()
		RegisterForUpdateChanceInsecure()
		RegisterForUpdateChanceHappy()
	EndFunction
EndProperty
float Function GetDefaultModifierSelfEsteem(float w) ; 
	; emotion = SelfEsteem, traits = +tough -honest +live
	float mod = FACET_Toughness*2.0+(100.0-HEXACO_Honesty)+HEXACO_eXtraversion*3.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Naivety = 0.5 ; Used for humiliation training efficiency
Float Property MOD_Naivety Hidden
	Float Function get()
		return __MOD_Naivety
	EndFunction
	Function set(Float value)
		if __MOD_Naivety == value
			return
		endif
		__MOD_Naivety = value
		SetModifierFromFaction(akRef,DOM01.DOMModNaivety, (__MOD_Naivety) )
		; Update dependencies
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty
float Function GetDefaultModifierNaivety(float w) ; Used by humiliation and oral training for submission
	; emotion = Shame, traits = -lively -open-minded +sensual
	float mod = (100.0-HEXACO_eXtraversion)*3.0+FACET_Sensuality*2.0+(100.0-HEXACO_Openness)
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Sociability = 0.5 ; Used for bondage training efficiency
Float Property MOD_Sociability Hidden
	Float Function get()
		return __MOD_Sociability
	EndFunction
	Function set(Float value)
		__MOD_Sociability = value
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty
float Function GetDefaultModifierSociability(float w) ; Used by train bondage and when released from bondage
	; emotion = Bondage, traits = +bold +submi +live
	float mod = FACET_Boldness+FACET_Submissivity*2+HEXACO_eXtraversion*3.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Daring = 0.5 ; Used for response to pleasure
Float Property MOD_Daring Hidden
	Float Function get()
		return __MOD_Daring
	EndFunction
	Function set(Float value)
		if __MOD_Daring == value
			return
		endif
		__MOD_Daring = value
		SetModifierFromFaction(akRef,DOM01.DOMModDaring, (__MOD_Daring) )
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty
float Function GetDefaultModifierDaring(float w) ; Used by train sex
	; emotion = Pleasure, traits = +tough +bold +live
	float mod = FACET_Toughness+FACET_Boldness*2.0+HEXACO_eXtraversion*3.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Ingenuity = 0.5
Float Property MOD_Ingenuity Hidden
	Float Function get()
		return __MOD_Ingenuity
	EndFunction
	Function set(Float value)
		if __MOD_Ingenuity == value
			return
		endif
		__MOD_Ingenuity = value
		SetModifierFromFaction(akRef,DOM01.DOMModIngenuity, (__MOD_Ingenuity) )
		; Update dependencies
		RegisterForUpdateChanceCrushed()
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty
float Function GetDefaultModifierIngenuity(float w) ; this is physical confusion
	; emotion = Confused/Amazed traits = -live -smart +emo
	float mod = (100.0-FACET_Smartness)*2.0+(100.0-HEXACO_eXtraversion)*3.0+HEXACO_Emotionality
	return NormModifier(mod)*w	
EndFunction

; --- Agreeableness related

Float __MOD_Gentleness = 0.5
Float Property MOD_Gentleness Hidden
	Float Function get()
		return __MOD_Gentleness
	EndFunction
	Function set(Float value)
		if __MOD_Gentleness == value
			return
		endif
		__MOD_Gentleness = value
		SetModifierFromFaction(akRef,DOM01.DOMModGentleness, (__MOD_Gentleness) )
		; Update dependencies
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty
float Function GetDefaultModifierGentleness(float w) ; Used by arousal events
	; emotion = +honesty +kind -wil
	float mod = HEXACO_Honesty+HEXACO_Agreeableness*3.0+(100.0-FACET_Wilfulness)*2.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Impatience = 0.5
Float Property MOD_Impatience Hidden
	Float Function get()
		return __MOD_Impatience
	EndFunction
	Function set(Float value)
		if __MOD_Impatience == value
			return
		endif
		__MOD_Impatience = value
		SetModifierFromFaction(akRef,DOM01.DOMModImpatience, (__MOD_Impatience) )
		; Update dependencies
		RegisterForUpdateChanceAngry()
		RegisterForUpdateChanceAngryForUnfairness()
		RegisterForUpdateChanceAngryForInjustice()
		RegisterForUpdateChanceJealous()
	EndFunction
EndProperty
float Function getDefaultModifierImpatience(float w) ; Used by anger events, this is anger building up
	; emotion = No stress, traits = -tough -kind +lively
	float mod = (100.0-FACET_Toughness)*2.0+(100.0-HEXACO_Agreeableness)*3.0+(HEXACO_eXtraversion)
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Flexibility = 0.5
Float Property MOD_Flexibility Hidden
	Float Function get()
		return __MOD_Flexibility
	EndFunction
	Function set(Float value)
		__MOD_Flexibility = value
		SetModifierFromFaction(akRef,DOM01.DOMModFlexibility, (__MOD_Flexibility) )
	EndFunction
EndProperty
float Function GetDefaultModifierFlexibility(float w) ; Used by pose training
	; emotion = Posing or in bondage, traits = +kind +sens +open
	float mod = HEXACO_Openness*3.0+FACET_Sensuality*2.0+HEXACO_Agreeableness
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Forgiveness = 0.5
Float Property MOD_Forgiveness Hidden
	Float Function get()
		return __MOD_Forgiveness
	EndFunction
	Function set(Float value)
		if __MOD_Forgiveness == value
			return
		endif
		__MOD_Forgiveness = value
		SetModifierFromFaction(akRef,DOM01.DOMModForgiveness, (__MOD_Forgiveness) )
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceJealous()
		RegisterForUpdateChanceDepressed()
		RegisterForUpdateChanceRecoverFromAfraid()
		RegisterForUpdateChanceRecoverFromShock()
		RegisterForUpdateChanceRecoverFromBroken()
	EndFunction
EndProperty
float Function getDefaultModiferForgiveness(float w) ; Used by anger training and pose training
	; emotion = Anger, traits = +kind +anxious +submi
	float mod = HEXACO_Agreeableness*3.0+FACET_Submissivity*2.0+HEXACO_Emotionality
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Empathy = 0.5
Float Property MOD_Empathy Hidden
	Float Function get()
		return __MOD_Empathy
	EndFunction
	Function set(Float value)
		if __MOD_Empathy == value
			return
		endif
		__MOD_Empathy = value
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceHappy()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceAngryForInjustice()
		RegisterForUpdateChanceSadForInjustice()
	EndFunction
EndProperty
float Function GetDefaultModifierEmpathy(float w) ; Used by make angry for friends
	; emotion = injustice, traits = +kind +bold +sens
	float mod = HEXACO_Agreeableness*3.0+FACET_Boldness*2.0+FACET_Sensuality
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Resentment = 0.5
Float Property MOD_Resentment Hidden
	Float Function get()
		return __MOD_Resentment
	EndFunction
	Function set(Float value)
		if __MOD_Resentment == value
			return
		endif
		__MOD_Resentment = value
		SetModifierFromFaction(akRef,DOM01.DOMModResentment, (__MOD_Resentment) )
		; Update dependencies
		RegisterForUpdateChancePunishedMultiplier()
		RegisterForUpdateChanceAngryForUnfairness()
		RegisterForUpdateChanceSadForUnfairness()
	EndFunction
EndProperty
float Function GetDefaultModifierResentment(float w) ; Used by make angry, recently punished
	; emotion = resentment, traits = +smart -kind +consciensous 
	float mod = FACET_Smartness*2.0+(100.0-HEXACO_Agreeableness)*3.0+(100.0-HEXACO_Conscientiousness)
	return NormModifier(mod)*w	
EndFunction

; --- Conscientiousness related

Float __MOD_Laborious = 0.5
Float Property MOD_Laborious Hidden
	Float Function get()
		return __MOD_Laborious
	EndFunction
	Function set(Float value)
		if __MOD_Laborious == value
			return
		endif
		__MOD_Laborious = value
		; Update dependencies
		RegisterForUpdateChanceJealous()
	EndFunction
EndProperty
float Function GetDefaultModifierLaborious(float w) ; Used by scold dialogue
	; emotion = Praise, traits = -wil -smart +consciensous
	float mod = (100.0-FACET_Wilfulness)*2.0+(100.0-FACET_Smartness)+HEXACO_Conscientiousness*3.0   
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Controller = 0.5 ; used by skill slaver
Float Property MOD_Controller Hidden
	Float Function get()
		return __MOD_Controller
	EndFunction
	Function set(Float value)
		if __MOD_Controller == value
			return
		endif
		__MOD_Controller = value
		SetModifierFromFaction(akRef,DOM01.DOMModController, (__MOD_Controller) )
		; Update dependencies
	EndFunction
EndProperty
float Function GetDefaultModifierController(float w) ; Used by slaver skill
	; emotion = Combat, traits = +cons -honesty -submi
	float mod = HEXACO_Conscientiousness*2.0+(100.0-FACET_Submissivity)*2.0+(100.0-HEXACO_Honesty)*2.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Diligent = 0.5
Float Property MOD_Diligent Hidden
	Float Function get()
		return __MOD_Diligent
	EndFunction
	Function set(Float value)
		if __MOD_Diligent == value
			return
		endif
		__MOD_Diligent = value
		SetModifierFromFaction(akRef,DOM01.DOMModDiligent, (__MOD_Diligent) )
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceInsecure()
		RegisterForUpdateChanceDepressed()
		RegisterForUpdateChanceFightForPlayer()
	EndFunction
EndProperty
float Function GetDefaultModifierDiligent(float w) ; Used by combat training
	; emotion = Combat, traits = +cons +tough -submi
	float mod = HEXACO_Conscientiousness*3.0+FACET_Toughness*2.0+(100.0-FACET_Submissivity)
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Consideration = 0.5
Float Property MOD_Consideration Hidden
	Float Function get()
		return __MOD_Consideration
	EndFunction
	Function set(Float value)
		if __MOD_Consideration == value
			return
		endif
		__MOD_Consideration = value
		SetModifierFromFaction(akRef,DOM01.DOMModConsideration, (__MOD_Consideration) )
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty
float Function GetDefaultModifierConsideration(float w) ; Used by comfort, inlove, loyal mood
	; emotion = Comfort, traits = +anxious +sensual +cons
	float mod = HEXACO_Emotionality+FACET_Sensuality*2.0+HEXACO_Conscientiousness*3.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Perfectionism = 0.5
Float Property MOD_Perfectionism Hidden
	Float Function get()
		return __MOD_Perfectionism
	EndFunction
	Function set(Float value)
		__MOD_Perfectionism = value
		SetModifierFromFaction(akRef,DOM01.DOMModPerfectionism, (__MOD_Perfectionism) )
	EndFunction
EndProperty
float Function GetDefaultModifierPerfectionism(float w) ; Used by house training
	; emotion = Taking care of house, traits = +subm +cons +lively
	float mod = HEXACO_Conscientiousness*3.0+FACET_Submissivity*2.0+HEXACO_eXtraversion
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Prudent = 0.5
Float Property MOD_Prudent Hidden
	Float Function get()
		return __MOD_Prudent
	EndFunction
	Function set(Float value)
		if __MOD_Prudent == value
			return
		endif
		__MOD_Prudent = value
		SetModifierFromFaction(akRef,DOM01.DOMModPrudent, (__MOD_Prudent) )
		; Update dependencies
		RegisterForUpdateChanceCrushed()
		RegisterForUpdateChanceAfraid()
		RegisterForUpdateChanceTerrified()
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceSadForUnfairness()
		RegisterForUpdateChanceSadForInjustice()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceDepressed()
	EndFunction
EndProperty
float Function GetDefaultModifierPrudent(float w) ; Used by resignation and vaginal training for respect
	; emotion = Sorrow, traits = +thorough -bold +kind 
	float mod = HEXACO_Conscientiousness*3.0+(100.0-FACET_Boldness)*2.0+HEXACO_Agreeableness
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Organized = 0.5
Float Property MOD_Organized Hidden
	Float Function get()
		return __MOD_Organized
	EndFunction
	Function set(Float value)
		if __MOD_Organized == value
			return
		endif
		__MOD_Organized = value
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceDepressed()
	EndFunction
EndProperty
float Function GetDefaultModifierOrganized(float w) ; Used by praise dialogue
	; emotion = Praise, traits = -smart -open +consciensous
	float mod = (100.0-FACET_Smartness)*2.0+(100.0-HEXACO_Openness)+HEXACO_Conscientiousness*3.0   
	return NormModifier(mod)*w	
EndFunction

; --- Open-mindness related

Float __MOD_Authority = 0.5
Float Property MOD_Authority Hidden
	Float Function get()
		return __MOD_Authority
	EndFunction
	Function set(Float value)
		if __MOD_Authority == value
			return
		endif
		__MOD_Authority = value
		SetModifierFromFaction(akRef,DOM01.DOMModAuthority, (__MOD_Authority) )
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceDepressed()
		RegisterForUpdateChanceRespectful()
	EndFunction
EndProperty
float Function GetDefaultModifierAuthority(float w) ; Used by respect events
	; emotion = subject to order, traits = -open -wil +cons
	float mod = (100.0-HEXACO_Openness)*3.0+HEXACO_Conscientiousness+(100.0-FACET_Wilfulness)*2.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Rebellion = 0.5
Float Property MOD_Rebellion Hidden
	Float Function get()
		return __MOD_Rebellion
	EndFunction
	Function set(Float value)
		if __MOD_Rebellion == value
			return
		endif
		__MOD_Rebellion = value
		; Update dependencies
		RegisterForUpdateChanceAngryForInjustice()
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceDefiant()
		RegisterForUpdateChanceJealous()
	EndFunction
EndProperty
float Function GetDefaultModifierRebellion(float w) ; Used by freedom events
	; emotion = Confused/Amazed traits = +open +tough +wil ; resilience: +5X +4C +3A +smart +friends
	float mod = (HEXACO_Openness)*3.0+(FACET_Toughness)*2.0+(FACET_Wilfulness)
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Hope = 0.5
Float Property MOD_Hope Hidden
	Float Function get()
		return __MOD_Hope
	EndFunction
	Function set(Float value)
		__MOD_Hope = value
		;SetModifierFromFaction(akRef,DOM01.DOMModHope, (__MOD_Hope) )
		RegisterForUpdateChanceHappy()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty
float Function GetDefaultModifierHope(float w) ; 
	; emotion = subject to order, traits = +wil +sensual +kind
	float mod = FACET_Wilfulness+HEXACO_Agreeableness*3.0+FACET_Sensuality*2.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Manipulation = 0.5
Float Property MOD_Manipulation Hidden
	Float Function get()
		return __MOD_Manipulation
	EndFunction
	Function set(Float value)
		if __MOD_Manipulation == value
			return
		endif
		__MOD_Manipulation = value
		SetModifierFromFaction(akRef,DOM01.DOMModManipulation, (__MOD_Manipulation) )
		; Update dependencies
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceHappy()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceRecoverFromBroken()
	EndFunction
EndProperty
float Function GetDefaultModifierManipulation(float w) ; this is mind confusion, used by recover from broken, praise and scold dialogues
	; emotion = Confused/Amazed traits = -open +sub +emo
	float mod = HEXACO_Emotionality+FACET_Submissivity*2.0+(100.0-HEXACO_Openness)*3.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Creativity = 0.5
Float Property MOD_Creativity Hidden
	Float Function get()
		return __MOD_Creativity
	EndFunction
	Function set(Float value)
		__MOD_Creativity = value
		SetModifierFromFaction(akRef,DOM01.DOMModCreativity, (__MOD_Creativity) )
		; Update dependencies
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceInsecure()
	EndFunction
EndProperty
float Function GetDefaultModifierCreativity(float w) 
	; emotion = subject to order, traits = +open +bold +sens
	float mod = HEXACO_Openness*3.0+FACET_Boldness*2.0+FACET_Sensuality
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Pretender = 0.5
Float Property MOD_Pretender Hidden
	Float Function get()
		return __MOD_Pretender
	EndFunction
	Function set(Float value)
		if __MOD_Pretender == value
			return
		endif
		__MOD_Pretender = value
		SetModifierFromFaction(akRef,DOM01.DOMModPretender, (__MOD_Pretender) )
		; Update dependencies
	EndFunction
EndProperty
float Function GetDefaultModifierPretender(float w) ; Used by respect training and pose training for resignation
	; emotion = Shame, traits = +open-minded -honest +smart
	float mod = HEXACO_Openness*2.0+FACET_Smartness*2.0+(100.0-HEXACO_Honesty)*2.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Discipline = 0.5
Float Property MOD_Discipline Hidden
	Float Function get()
		return __MOD_Discipline
	EndFunction
	Function set(Float value)
		if __MOD_Discipline == value
			return
		endif
		__MOD_Discipline = value
		SetModifierFromFaction(akRef,DOM01.DOMModDiscipline, (__MOD_Discipline) )
		; Update dependencies
		RegisterForUpdateChanceCrushed()
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceJealous()
	EndFunction
EndProperty
float Function GetDefaultModifierDiscipline(float w) ; Used by respect training and pose training for resignation
	; emotion = Shame, traits = -open-minded +lievely -smart
	float mod = (100.0-HEXACO_Openness)*3.0+(100.0-FACET_Smartness)*2.0+HEXACO_eXtraversion
	return NormModifier(mod)*w	
EndFunction

; --- Sex training related

Float __MOD_Vaginal = 0.5
Float Property MOD_Vaginal Hidden
	Float Function get()
		return __MOD_Vaginal
	EndFunction
	Function set(Float value)
		__MOD_Vaginal = value
		SetModifierFromFaction(akRef,DOM01.DOMModVaginal, (__MOD_Vaginal) )
	EndFunction
EndProperty
float Function GetDefaultModifierVaginal(float w) ; Used by vaginal training
	; emotion = sex, traits = +honest +subm +(sensual +wil)/2
	float mod = HEXACO_Honesty*2.0+(FACET_Submissivity)*2.0+FACET_Sensuality+FACET_Wilfulness
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Oral = 0.5
Float Property MOD_Oral Hidden
	Float Function get()
		return __MOD_Oral
	EndFunction
	Function set(Float value)
		__MOD_Oral = value
		SetModifierFromFaction(akRef,DOM01.DOMModOral, (__MOD_Oral) )
	EndFunction
EndProperty
float Function GetDefaultModifierOral(float w) ; Used by oral training
	; emotion = sex, traits = -lively +(submi +sens)/2 +cons
	float mod = (100.0-HEXACO_eXtraversion)*2.0+HEXACO_Conscientiousness*2.0+FACET_Submissivity+FACET_Sensuality
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Anal = 0.5
Float Property MOD_Anal Hidden
	Float Function get()
		return __MOD_Anal
	EndFunction
	Function set(Float value)
		__MOD_Anal = value
		SetModifierFromFaction(akRef,DOM01.DOMModAnal, (__MOD_Anal) )
	EndFunction
EndProperty
float Function GetDefaultModifierAnal(float w) ; Used by anal training
	; emotion = sex, traits = +(submi +wil)/2 -open +kind
	float mod = FACET_Submissivity+FACET_Wilfulness+(100.0-HEXACO_Openness)*2.0+HEXACO_Agreeableness*2.0
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Orgasm = 0.5
Float Property MOD_Orgasm Hidden
	Float Function get()
		return __MOD_Orgasm
	EndFunction
	Function set(Float value)
		if __MOD_Orgasm == value
			return
		endif
		__MOD_Orgasm = value
		; Update dependencies
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateTrainingStatus()
	EndFunction
EndProperty
float Function getDefaultModifierOrgasm(float w) ; Used by arousal events
	; emotion = Orgasm, +sensual, +bold, -tough
	float mod = FACET_Sensuality*3.0+(100.0-FACET_Toughness)*2.0+FACET_Boldness
	return NormModifier(mod)*w	
EndFunction

Float __MOD_Addict = 0.5
Float Property MOD_Addict Hidden
	Float Function get()
		return __MOD_Addict
	EndFunction
	Function set(Float value)
		if __MOD_Addict == value
			return
		endif
		__MOD_Addict = value
		; Update dependencies
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateTrainingStatus()
	EndFunction
EndProperty
float Function getDefaultModifierAddict(float w) ; Used by arousal events
	; emotion = Addict, -honest, -kind, -cons
	float mod = (100.0-HEXACO_Honesty)*2.0+(100.0-HEXACO_Agreeableness)*2.0+(100.0-HEXACO_Conscientiousness)*2.0
	return NormModifier(mod)*w
EndFunction

Float __MOD_Combat = 0.5
Float Property MOD_Combat Hidden
	Float Function get()
		return __MOD_Combat
	EndFunction
	Function set(Float value)
		if __MOD_Combat == value
			return
		endif
		__MOD_Combat = value
		SetModifierFromFaction(akRef,DOM01.DOMModCombat, (__MOD_Combat) )
		; Update dependencies
	EndFunction
EndProperty
float Function getDefaultModifierCombat(float w) ; Used by combat events
	; emotion = combat: +bold +wil +smart
	float mod = FACET_Boldness*2.0+FACET_Wilfulness*2.0+FACET_Smartness*2.0
	return NormModifier(mod)*w	
EndFunction

; ### Main training values ###

; global training value excluding sex and combat
Float __total_training = 0.0
Float Property total_training Hidden
	Float Function get()
		return __total_training
	EndFunction
	Function set(Float value)
		if __total_training == value
			return
		endif
		__total_training = value
		if __total_training >= 100.0
			actor_alias.SendExternalEventS("TrainingComplete")
		endif
		; Update dependencies
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceRecoverFromBroken()
		RegisterForUpdateTrainingStatus()
	EndFunction
EndProperty
float Function TotalTraining()
	return (submission+resignation+humiliation+fear_training+anger_training+respect_training)/6.0
EndFunction

Float __total_love_feelings = 0.0
Float Property total_love_feelings Hidden
	Float Function get()
		return __total_love_feelings
	EndFunction
	Function set(Float value)
		if __total_love_feelings == value
			return
		endif
		__total_love_feelings = value
		if __total_love_feelings >= 100.0
			actor_alias.SendExternalEventS("LoveComplete")
		endif
		; Update dependencies
		RegisterForUpdateChanceInLove()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateTrainingStatus()
	EndFunction
EndProperty
float Function TotalLoveFeelings()
	return (love_admiration+love_desire+love_fascination)/3.0
EndFunction

Float __total_loyal_feelings = 0.0
Float Property total_loyal_feelings Hidden
	Float Function get()
		return __total_loyal_feelings
	EndFunction
	Function set(Float value)
		if __total_loyal_feelings == value
			return
		endif
		__total_loyal_feelings = value
		if __total_loyal_feelings >= 100.0
			actor_alias.SendExternalEventS("LoyalComplete")
		endif
		; Update dependencies
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInLove()
		RegisterForUpdateTrainingStatus()
	EndFunction
EndProperty
float Function TotalLoyalFeelings()
	return (loyal_absolution+loyal_devotion+loyal_worship)/3.0
EndFunction

Float __submission = 0.0
Float Property submission Hidden
	Float Function get()
		return __submission
	EndFunction
	Function set(Float value)
		if __submission == value
			return
		endif
		__submission = value
		if __submission > 100.0
			__submission = 100.0
		elseif __submission < 0.0
			__submission = 0.0
		endif
		akRef.SetFactionRank(DOM01.DOMTrainSubmission, __submission as Int)
		; Update dependencies
		total_training     = TotalTraining()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceRecoverFromDepressed()
		RegisterForUpdateChanceRespectful()

		actor_alias.SendExternalEventSSF("TrainingStatChange","Submission",__submission)
	EndFunction
EndProperty
Float __love_desire = 0.0
Float Property love_desire Hidden
	Float Function get()
		return __love_desire
	EndFunction
	Function set(Float value)
		if __love_desire == value
			return
		endif
		__love_desire = value
		if __love_desire > 127.0
			akRef.SetFactionRank(DOM01.DOMLoveDesire, 127)
		else
			if __love_desire < 0.0
				__love_desire = 0.0
			endif
			akRef.SetFactionRank(DOM01.DOMLoveDesire, __love_desire as Int)
		endif
		
		; Update dependencies
		total_love_feelings     = TotalLoveFeelings()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
		actor_alias.SendExternalEventSSF("TrainingStatChange","Desire",__love_desire)
	EndFunction
EndProperty

Float __fear_training = 0.0
Float Property fear_training Hidden
	Float Function Get()
		return __fear_training
	EndFunction
	Function Set(Float value)
		if __fear_training == value
			return
		endif
		if value > 100.0
			__fear_training = 100.0
		elseif value < 0.0
			__fear_training = 0.0
		else
			__fear_training = value
		endif
		akRef.SetFactionRank(DOM01.DOMTrainFear, __fear_training as Int)
		; Update dependencies
		; Update dependencies
		total_training      = TotalTraining()
		RegisterForUpdateChanceAfraid()
		RegisterForUpdateChanceScared()
		RegisterForUpdateChanceTerrified()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceRecoverFromAfraid()

		actor_alias.SendExternalEventSSF("TrainingStatChange","Fear",__fear_training)
	EndFunction
EndProperty
Float __loyal_worship = 0.0
Float Property loyal_worship Hidden
	Float Function get()
		return __loyal_worship
	EndFunction
	Function set(Float value)
		if __loyal_worship == value
			return
		endif
		__loyal_worship = value
		if __loyal_worship > 127.0
			akRef.SetFactionRank(DOM01.DOMLoyalWorship, 127)
		else
			if __loyal_worship < 0.0
				__loyal_worship = 0.0
			endif
			akRef.SetFactionRank(DOM01.DOMLoyalWorship, __loyal_worship as Int)
		endif

		; Update dependencies
		total_loyal_feelings     = TotalLoyalFeelings()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceLoyal()

		actor_alias.SendExternalEventSSF("TrainingStatChange","Worship",__loyal_worship)
	EndFunction
EndProperty

Float __humiliation = 0.0
Float Property humiliation Hidden
	Float Function get()
		;LogTrace("humiliation.Get() : "+name+" = "+__humiliation)	
		return __humiliation
	EndFunction
	Function set(Float value)
		;LogTrace("humiliation.Set() : "+name)	
		if __humiliation == value
			return
		endif
		__humiliation = value
		if __humiliation > 100.0
			__humiliation = 100.0
		elseif __humiliation < 0.0
			__humiliation = 0.0
		endif
		akRef.SetFactionRank(DOM01.DOMTrainHumiliation, __humiliation as Int)
		; Update dependencies
		total_training      = TotalTraining()
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceRecoverFromAshamed()

		actor_alias.SendExternalEventSSF("TrainingStatChange","Humiliation",__humiliation)
	EndFunction
EndProperty
Float __love_fascination = 0.0
Float Property love_fascination Hidden
	Float Function get()
		return __love_fascination
	EndFunction
	Function set(Float value)
		if __love_fascination == value
			return
		endif
		__love_fascination = value
		if __love_fascination > 127.0
			akRef.SetFactionRank(DOM01.DOMLoveFascination, 127)
		else
			if __love_fascination < 0.0
				__love_fascination = 0.0
			endif
			akRef.SetFactionRank(DOM01.DOMLoveFascination, __love_fascination as Int)
		endif

		; Update dependencies
		total_love_feelings     = TotalLoveFeelings()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()

		actor_alias.SendExternalEventSSF("TrainingStatChange","Fascination",__love_fascination)
	EndFunction
EndProperty

Float __anger_training = 0.0
Float Property anger_training Hidden
	Float Function get()
		return __anger_training
	EndFunction
	Function set(Float value)
		if __anger_training == value
			return
		endif
		__anger_training = value
		if __anger_training > 100.0
			__anger_training = 100.0
		elseif __anger_training < 0.0
			__anger_training = 0.0
		endif
		akRef.SetFactionRank(DOM01.DOMTrainAnger, __anger_training as Int)
		; Update dependencies
		total_training = TotalTraining()
		RegisterForUpdateChanceAngry()
		RegisterForUpdateChanceAngryForUnfairness()
		RegisterForUpdateChanceAngryForInjustice()
		RegisterForUpdateChanceDefiant()
		RegisterForUpdateChanceHappy()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceRecoverFromAngry()
		RegisterForUpdateChanceRecoverFromJealous()

		actor_alias.SendExternalEventSSF("TrainingStatChange","Anger",__anger_training)
	EndFunction
EndProperty
Float __loyal_absolution = 0.0
Float Property loyal_absolution Hidden
	Float Function get()
		return __loyal_absolution
	EndFunction
	Function set(Float value)
		if __loyal_absolution == value
			return
		endif
		__loyal_absolution = value
		if __loyal_absolution > 127.0
			akRef.SetFactionRank(DOM01.DOMLoyalAbsolution, 127)
		else
			if __loyal_absolution < 0.0
				__loyal_absolution = 0.0
			endif
			akRef.SetFactionRank(DOM01.DOMLoyalAbsolution, __loyal_absolution as Int)
		endif

		; Update dependencies
		total_loyal_feelings     = TotalLoyalFeelings()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceLoyal()

		actor_alias.SendExternalEventSSF("TrainingStatChange","Absolution",__loyal_absolution)
	EndFunction
EndProperty

Float __resignation = 0.0
Float Property resignation Hidden
	Float Function get()
		;LogTrace("resignation.Get() : "+name+" = "+__resignation)	
		return __resignation
	EndFunction
	Function set(Float value)
		;LogTrace("resignation.Set() : "+name)	
		if __resignation == value
			return
		endif
		__resignation = value
		if __resignation > 100.0
			__resignation = 100.0
		elseif __resignation < 0.0
			__resignation = 0.0
		endif
		akRef.SetFactionRank(DOM01.DOMTrainResignation, __resignation as Int)
		; Update dependencies
		total_training      = TotalTraining()
		RegisterForUpdateChanceRunAway()
		RegisterForUpdateChanceRunAwayGang()
		RegisterForUpdateChanceAngryForUnfairness()
		RegisterForUpdateChanceAngryForInjustice()
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceSadForUnfairness()
		RegisterForUpdateChanceSadForInjustice()
		RegisterForUpdateChanceCrushed()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChancePunishedMultiplier()
		RegisterForUpdateChanceRecoverFromSad()
		RegisterForUpdateChanceFightForPlayer()

		actor_alias.SendExternalEventSSF("TrainingStatChange","Resignation",__resignation)
	EndFunction
EndProperty
Float __loyal_devotion = 0.0
Float Property loyal_devotion Hidden
	Float Function get()
		return __loyal_devotion
	EndFunction
	Function set(Float value)
		if __loyal_devotion == value
			return
		endif
		__loyal_devotion = value
		if __loyal_devotion > 127.0
			akRef.SetFactionRank(DOM01.DOMLoyalDevotion, 127)
		else
			if __loyal_devotion < 0.0
				__loyal_devotion = 0.0
			endif
			akRef.SetFactionRank(DOM01.DOMLoyalDevotion, __loyal_devotion as Int)
		endif

		; Update dependencies
		total_loyal_feelings     = TotalLoyalFeelings()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceLoyal()

		actor_alias.SendExternalEventSSF("TrainingStatChange","Devotion",__loyal_devotion)
	EndFunction
EndProperty

Float __respect_training = 0.0
Float Property respect_training Hidden
	Float Function get()
		return __respect_training
	EndFunction
	Function set(Float value)
		;LogTrace("Respect training update: "+respect_training+" -> "+value)
		if __respect_training == value
			return
		endif
		__respect_training = value
		if __respect_training > 100.0
			__respect_training = 100.0
		elseif __respect_training < 0.0
			__respect_training = 0.0
		endif
		akRef.SetFactionRank(DOM01.DOMTrainRespect, __respect_training as Int)
		; Update dependencies
		total_training     = TotalTraining()
		RegisterForUpdateChanceDefiant()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceRespectful()

		actor_alias.SendExternalEventSSF("TrainingStatChange","Respect",__respect_training)
		;LogTrace("Respect training updated -> "+respect_training)
	EndFunction
EndProperty
Float __love_admiration = 0.0
Float Property love_admiration Hidden
	Float Function get()
		return __love_admiration
	EndFunction
	Function set(Float value)
		if __love_admiration == value
			return
		endif
		__love_admiration = value
		if __love_admiration > 127.0
			akRef.SetFactionRank(DOM01.DOMLoveAdmiration, 127)
		else
			if __love_admiration < 0.0
				__love_admiration = 0.0
			endif
			akRef.SetFactionRank(DOM01.DOMLoveAdmiration, __love_admiration as Int)
		endif

		; Update dependencies
		total_love_feelings     = TotalLoveFeelings()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()

		actor_alias.SendExternalEventSSF("TrainingStatChange","Admiration",__love_admiration)
	EndFunction
EndProperty

; ### Slaver skills ###

Float Function GetSkillsDisciplineModifier(float amount)
	if IsDevoted()
		return amount ; devoted slaves and slavers get the highest modifier and no effect from discipline modifier
	endif
	if !is_slave
		return amount*5.0/(10.0-MOD_Discipline) ; divided by 1.0 to 2.0 for slavers
	endif
	if IsObedient()
		return amount*4.0/(10.0-MOD_Discipline) ; divided by 1.5 to 2.5 for broken slaves
	endif
	return amount*2.0/(10.0-MOD_Discipline) ; divided by 2.5 to 5.0 for fresh slaves
EndFunction

Float __skill_enforcer = 0.0 ; Training slaves physically (pain) ; Physical + sexual
Float Property skill_enforcer Hidden
	Float Function Get()
		return __skill_enforcer
	EndFunction
	Function Set(float value)
		if value < 0.0
			value = 0.0
		endif
		if value > 100.0
			value = 100.0
		endif	
		__skill_enforcer = value
		akRef.SetFactionRank(DOM01.DOMSkillEnforcer, __skill_enforcer as Int)
	EndFunction
EndProperty
Function TrainSkillEnforcer(Float base_amount)
	if __skill_enforcer < 100.0
		if actorType > 1 ; for creatures 
			base_amount = base_amount * 1.5
		endif
		Float multiplier = 0.1 + (0.9*(1.0-(__skill_enforcer/100.0)))
		skill_enforcer += (multiplier*MOD_Insensitivity)*GetSkillsDisciplineModifier(base_amount)
	endif
EndFunction
Float Function GetEnforcerModifier()
	return 0.5+__skill_enforcer/100.0
EndFunction

Float __skill_persuader = 0.0 ; Scaring slaves ; Physical
Float Property skill_persuader Hidden
	Float Function Get()
		return __skill_persuader
	EndFunction
	Function Set(float value)
		if value < 0.0
			value = 0.0
		endif
		if value > 100.0
			value = 100.0
		endif	
		__skill_persuader = value
		akRef.SetFactionRank(DOM01.DOMSkillPersuader, __skill_persuader as Int)
	EndFunction
EndProperty
Function TrainSkillPersuader(Float base_amount)
	if __skill_persuader < 100.0
		if actorType > 1 ; for creatures
			base_amount = base_amount * 2.0
		endif
		Float multiplier = 0.1 + (0.9*(1.0-(__skill_persuader/100.0)))
		skill_persuader += (multiplier*MOD_Intimidate)*GetSkillsDisciplineModifier(base_amount)
	endif
EndFunction
Float Function GetPersuaderModifier()
	return 0.5+__skill_persuader/100.0
EndFunction

Float __skill_depraver = 0.0 ; Training slaves sexually ; Sexual
Float Property skill_depraver Hidden
	Float Function Get()
		return __skill_depraver
	EndFunction
	Function Set(float value)
		if value < 0.0
			value = 0.0
		endif
		if value > 100.0
			value = 100.0
		endif	
		__skill_depraver = value
		akRef.SetFactionRank(DOM01.DOMSkillDepraver, __skill_depraver as Int)
	EndFunction
EndProperty
Function TrainSkillDepraver(Float base_amount)
	if __skill_depraver < 100.0
		if actorType == 1 ; for animals
			base_amount = base_amount * 0.5
		endif
		Float multiplier = 0.1 + (0.9*(1.0-(__skill_depraver/100.0)))
		skill_depraver += (multiplier*MOD_SelfEsteem)*GetSkillsDisciplineModifier(base_amount)
	endif
EndFunction
Float Function GetDepraverModifier()
	return 0.5+__skill_depraver/100.0
EndFunction

Float __skill_predator = 0.0 ; Capturing slaves ; Sexual and psychological
Float Property skill_predator Hidden
	Float Function Get()
		return __skill_predator
	EndFunction
	Function Set(float value)
		if value < 0.0
			value = 0.0
		endif
		if value > 100.0
			value = 100.0
		endif	
		__skill_predator = value
		akRef.SetFactionRank(DOM01.DOMSkillPredator, __skill_predator as Int)
	EndFunction
EndProperty
Function TrainSkillPredator(Float base_amount)
	if __skill_predator < 100.0
		if actorType > 1 ; for creatures
			base_amount = base_amount * 0.5
		endif
		Float multiplier = 0.1 + (0.9*(1.0-(__skill_predator/100.0)))
		skill_predator += (multiplier*MOD_Resentment)*GetSkillsDisciplineModifier(base_amount)
	endif
EndFunction
Float Function GetPredatorModifier()
	return 0.5+__skill_predator/100.0
EndFunction

Float __skill_slaver = 0.0 ; Selling slaves ; Physical and Psychological
Float Property skill_slaver Hidden
	Float Function Get()
		return __skill_slaver
	EndFunction
	Function Set(float value)
		if value < 0.0
			value = 0.0
		endif
		if value > 100.0
			value = 100.0
		endif	
		__skill_slaver = value
		akRef.SetFactionRank(DOM01.DOMSkillSlaver, __skill_slaver as Int)
	EndFunction
EndProperty
Function TrainSkillSlaver(Float base_amount)
	if __skill_slaver < 100.0
		if actorType > 1 ; for creatures
			base_amount = base_amount * 0.5
		endif
		Float multiplier = 0.1 + (0.9*(1.0-(__skill_slaver/100.0)))
		skill_slaver += (multiplier*MOD_Controller)*GetSkillsDisciplineModifier(base_amount)
	endif
EndFunction
Float Function GetSlaverModifier()
	return 0.5+__skill_slaver/100.0
EndFunction

Float __skill_deceiver = 0.0 ;  Brainwashing slaves ; Psychological
Float Property skill_deceiver Hidden
	Float Function Get()
		return __skill_deceiver
	EndFunction
	Function Set(float value)
		if value < 0.0
			value = 0.0
		endif
		if value > 100.0
			value = 100.0
		endif	
		__skill_deceiver = value
		akRef.SetFactionRank(DOM01.DOMSkillDeceiver, __skill_deceiver as Int)
	EndFunction
EndProperty
Function TrainSkillDeceiver(Float base_amount)
	if __skill_deceiver < 100.0
		if actorType > 0 ; for creatures and animals
			base_amount = base_amount * 0.25
		endif
		Float multiplier = 0.1 + (0.9*(1.0-(__skill_deceiver/100.0)))
		skill_deceiver += (multiplier*MOD_Pretender)*GetSkillsDisciplineModifier(base_amount)
	endif
EndFunction
Float Function GetDeceiverModifier()
	return 0.5+__skill_deceiver/100.0
EndFunction

; ### Sex training values ###

; global sex training value
Float __sex_training = 0.0
Float Property sex_training Hidden
	Float Function get()
		return __sex_training
	EndFunction
	Function set(Float value)
		__sex_training = ((oral_training + vaginal_training + anal_training) / 3.0)

		if __sex_training > 100.0
			__sex_training = 100.0
		elseif __sex_training < 0.0
			__sex_training = 0.0
		endif
		akRef.SetFactionRank(DOM01.DOMTrainSex, __sex_training as Int)
	EndFunction
EndProperty

Float __anal_training = 0.0
Float Property anal_training Hidden
	Float Function get()
		return __anal_training
	EndFunction
	Function set(Float value)
		if __anal_training == value
			return
		endif
		__anal_training = value
		if __anal_training > 100.0
			__anal_training = 100.0
		elseif __anal_training < 0.0
			__anal_training = 0.0
		endif
		sex_training = 0.0
		akRef.SetFactionRank(DOM01.DOMTrainAnal, __anal_training as Int)
	EndFunction
EndProperty

Float __oral_training = 0.0
Float Property oral_training Hidden
	Float Function get()
		return __oral_training
	EndFunction
	Function set(Float value)
		if __oral_training == value
			return
		endif
		__oral_training = value
		if __oral_training > 100.0
			__oral_training = 100.0
		elseif __oral_training < 0.0
			__oral_training = 0.0
		endif
		sex_training = 0.0
		akRef.SetFactionRank(DOM01.DOMTrainOral, __oral_training as Int)
	EndFunction
EndProperty

Float __vaginal_training = 0.0
Float Property vaginal_training Hidden
	Float Function get()
		return __vaginal_training
	EndFunction
	Function set(Float value)
		if __vaginal_training == value
			return
		endif
		__vaginal_training = value
		if __vaginal_training > 100.0
			__vaginal_training = 100.0
		elseif __vaginal_training < 0.0
			__vaginal_training = 0.0
		endif
		sex_training = 0.0
		akRef.SetFactionRank(DOM01.DOMTrainVaginal, __vaginal_training as Int)
	EndFunction
EndProperty

; ### Secondary training values ###

Float __combat_training = 0.0
Float Property combat_training Hidden
	Float Function get()
		return __combat_training
	EndFunction
	Function set(Float value)
		if __combat_training == value
			return
		endif
		float initialTraining = __combat_training
		__combat_training = value
		if __combat_training > 127.0
			__combat_training = 127.0
		elseif __combat_training < 0.0
			__combat_training = 0.0
		endif
		SetFactionRankFloat(akRef, DOM01.DOMTrainCombat, __combat_training)
		UpdateCombatStrength(initialTraining)
		; Update dependencies
		RegisterForUpdateChanceFightForPlayer()
	EndFunction
EndProperty

Float __pose_training = 0.0
Float Property pose_training Hidden
	Float Function get()
		return __pose_training
	EndFunction
	Function set(Float value)
		if __pose_training == value
			return
		endif
		__pose_training = value
		if __pose_training > 100.0
			__pose_training = 100.0
		elseif __pose_training < 0.0
			__pose_training = 0.0
		endif
		akRef.SetFactionRank(DOM01.DOMTrainPose, __pose_training as Int)
	EndFunction
EndProperty

Float __house_training = 0.0
Float Property house_training Hidden
	Float Function get()
		return __house_training
	EndFunction
	Function set(Float value)
		if __house_training == value
			return
		endif
		__house_training = value
		if __house_training > 100.0
			__house_training = 100.0
		elseif __house_training < 0.0
			__house_training = 0.0
		endif
		akRef.SetFactionRank(DOM01.DOMTrainHouse, __house_training as Int)
	EndFunction
EndProperty

Float __work_training = 0.0
Float Property work_training Hidden
	Float Function get()
		return __work_training
	EndFunction
	Function set(Float value)
		if __work_training == value
			return
		endif
		__work_training = value
		if __work_training > 100.0
			__work_training = 100.0
		elseif __work_training < 0.0
			__work_training = 0.0
		endif
		akRef.SetFactionRank(DOM01.DOMTrainWorking, __work_training as Int)
	EndFunction
EndProperty

; ### Untraining

Function IncreaseAnger(Float base_amount)
	if IsDevoted()
		return
	endif
	if anger_training > 0.0 && anger_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(anger_training/100.0)))
		anger_training -= (multiplier*MOD_Resentment*base_amount*0.25)
	endif
EndFunction

Function IncreaseAngerForFriend(Float base_amount)
	if IsDevoted()
		return
	endif
	if anger_training > 0.0 && anger_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(anger_training/100.0)))
		anger_training -= (multiplier*MOD_Empathy*base_amount*0.25)
	endif
EndFunction

Function IncreaseAngerForGreed(Float base_amount)
	if IsDevoted()
		return
	endif
	if anger_training > 0.0 && anger_training < 100.0
		Float multiplier = 0.5 + (0.5*(1.0-(anger_training/100.0)))
		anger_training -= (multiplier*MOD_Greed*base_amount*0.25)
	endif
EndFunction

; ### Training Functions by reason ###

Function TrainForWornDevice(float severity, int ireason)
	; Train pose and submission (through bondage) for worn devices
	
	; Fill up efficiencies to avoid calling twice the same Functions
	float eff_bondage = 0.0
	float eff_pose = 0.0
	if actor_alias.has_dwarven_device
		eff_bondage = 0.35
		eff_pose    = 0.25
	elseif actor_alias.has_petsuit || actor_alias.has_straitjacket
		eff_bondage = 0.3
		eff_pose    = 0.2
	elseif actor_alias.has_armbinder || actor_alias.has_yoke
		if actor_alias.has_disablekick
			eff_bondage = 0.25
			eff_pose    = 0.15
		else
			eff_bondage = 0.2
			eff_pose    = 0.1
		endif
	endif
	if actor_alias.has_mouth_gag
		eff_bondage += 0.1
	endif

	if ireason == 14  ; "didnt fight"
		if actor_alias.has_petsuit
			TrainCombat(severity*0.25)
			TrainVaginal(severity*0.1)
			TrainAnal(severity*0.1)
			eff_pose    += 0.1
		elseif actor_alias.has_straitjacket && actor_alias.has_disablekick
			TrainCombat(severity*0.2)
			eff_pose    += 0.05
		elseif actor_alias.has_armbinder || actor_alias.has_yoke
			if actor_alias.has_disablekick
				TrainCombat(severity*0.15)
			else
				TrainCombat(severity*0.10)
			endif
		elseif actor_alias.has_straitjacket
			TrainCombat(severity*0.05)
		endif
	endif

	if actor_alias.has_plug_vaginal
		TrainVaginal(severity*0.25)
	endif
	if actor_alias.has_plug_anal
		TrainAnal(severity*0.25)
	endif
	
	TrainForBondage(severity * eff_bondage)
	TrainPose(severity * eff_pose)
EndFunction

float Function GetModifierByName(string the_mod)
	if the_mod == "anxiety"
		return MOD_Anxiety
	elseif the_mod == "authority"
		return MOD_Authority
	elseif the_mod == "consideration"
		return MOD_Consideration
	elseif the_mod == "controller"
		return MOD_Controller
	elseif the_mod == "creativity"
		return MOD_Creativity
	elseif the_mod == "criminality"
		return MOD_Criminality
	elseif the_mod == "daring"
		return MOD_Daring
	elseif the_mod == "dependence"
		return MOD_Dependence
	elseif the_mod == "diligent"
		return MOD_Diligent
	elseif the_mod == "discipline"
		return MOD_Discipline
	elseif the_mod == "empathy"
		return MOD_Empathy
	elseif the_mod == "fearfulness"
		return MOD_Fearfulness
	elseif the_mod == "flexibility"
		return MOD_Flexibility
	elseif the_mod == "greed"
		return MOD_Greed
	elseif the_mod == "hope"
		return MOD_Hope
	elseif the_mod == "humility"
		return MOD_Humility
	elseif the_mod == "ingenuity"
		return MOD_Ingenuity
	elseif the_mod == "insensitivity"
		return MOD_Insensitivity
	elseif the_mod == "intimidate"
		return MOD_Intimidate
	elseif the_mod == "laborious"
		return MOD_Laborious
	elseif the_mod == "naivety"
		return MOD_Naivety
	elseif the_mod == "organized"
		return MOD_Organized
	elseif the_mod == "orgasm"
		return MOD_Orgasm
	elseif the_mod == "addict"
		return MOD_Addict
	elseif the_mod == "pretender"
		return MOD_Pretender
	elseif the_mod == "rebellion"
		return MOD_Rebellion
	elseif the_mod == "resentment"
		return MOD_Resentment
	elseif the_mod == "selfesteem"
		return MOD_SelfEsteem
	elseif the_mod == "sentimentality"
		return MOD_Sentimentality
	elseif the_mod == "sociability"
		return MOD_Sociability
	elseif the_mod == "oral"
		return MOD_Oral
	elseif the_mod == "vaginal"
		return MOD_Vaginal
	elseif the_mod == "anal"
		return MOD_Anal
	endif
	return -1.0
EndFunction

float Function GetTrainingByName(string the_stat)
	if the_stat == "submission"
		return submission
	elseif the_stat == "fear"
		return fear_training
	elseif the_stat == "humiliation"
		return humiliation
	elseif the_stat == "anger"
		return anger_training
	elseif the_stat == "resignation"
		return resignation
	elseif the_stat == "respect"
		return respect_training
	elseif the_stat == "oral"
		return oral_training
	elseif the_stat == "vaginal"
		return vaginal_training
	elseif the_stat == "anal"
		return anal_training
	elseif the_stat == "pose"
		return pose_training
	elseif the_stat == "combat"
		return combat_training
	elseif the_stat == "house"
		return house_training
	elseif the_stat == "work"
		return work_training
	elseif the_stat == "enforcer"
		return skill_enforcer
	elseif the_stat == "persuader"
		return skill_persuader
	elseif the_stat == "depraver"
		return skill_depraver
	elseif the_stat == "predator"
		return skill_predator
	elseif the_stat == "slaver"
		return skill_slaver
	elseif the_stat == "deceiver"
		return skill_deceiver
	endif
	return -1.0
EndFunction

bool Function TrainFromArrays(float severity, string mod_arousal, string[] mod_stats, float[] mod_values)
	;LogTrace("TrainFromArrays: modifier="+mod_arousal)
	if !mod_stats
		LogTrace("TrainFromArrays: ERROR could not find stats")
		return false
	endif
	bool all_good = true
	int n = mod_stats.length
	int i = 0
	float mod = 0.01
	while i < n
		if mod_values && i < mod_values.length
			mod = mod_values[i]
		endif
		string the_stat = mod_stats[i]
		;LogTrace("TrainFromArrays: stat="+the_stat)
		if the_stat == "submission"
			TrainSubmission(severity * mod)
		elseif the_stat == "fear"
			TrainFear(severity * mod)
		elseif the_stat == "humiliation"
			TrainHumiliation(severity * mod)
		elseif the_stat == "anger"
			TrainAnger(severity * mod)
		elseif the_stat == "resignation"
			TrainResignation(severity * mod)
		elseif the_stat == "respect"
			TrainRespect(severity * mod)
		elseif the_stat == "oral"
			TrainOral(severity * mod)
		elseif the_stat == "vaginal"
			TrainVaginal(severity * mod)
		elseif the_stat == "anal"
			TrainAnal(severity * mod)
		elseif the_stat == "pose"
			TrainPose(severity * mod)
		elseif the_stat == "combat"
			TrainCombat(severity * mod)
		elseif the_stat == "house"
			TrainHouse(severity * mod)
		elseif the_stat == "work"
			TrainWork(severity * mod)
		elseif the_stat == "bondage"
			TrainForBondage(severity * mod)
		elseif the_stat == "discipline"
			TrainForDiscipline(severity * mod)
		elseif the_stat == "greed"
			TrainForGreed(severity * mod)
		elseif the_stat == "enforcer"
			TrainSkillEnforcer(severity * mod)
		elseif the_stat == "persuader"
			TrainSkillPersuader(severity * mod)
		elseif the_stat == "depraver"
			TrainSkillDepraver(severity * mod)
		elseif the_stat == "predator"
			TrainSkillPredator(severity * mod)
		elseif the_stat == "slaver"
			TrainSkillSlaver(severity * mod)
		elseif the_stat == "deceiver"
			TrainSkillDeceiver(severity * mod)
		elseif the_stat == "arousal"
			float the_mod = GetModifierByName(mod_arousal)
			if the_mod >= 0.0
				IncreaseArousal(mod*100.0,the_mod)
			else
				all_good = false
				LogTrace("TrainFromArrays: ERROR could not find modifier "+mod_arousal)
			endif
		else 
			all_good = false
			LogTrace("TrainFromArrays: ERROR could not find stat "+the_stat)
		endif
		i += 1
	endwhile
	return all_good
EndFunction

Function TrainForReason(float severity, int reason)
	if force_crying_as_punishment_reason && reason == 4 ; "crying"
		force_crying_as_punishment_reason = false
	endif
	bool broken = false
	if IsBrokenToObey() || IsObedient()
		broken = true
	elseif RandomFloat()*2.0+0.5 < MOD_SumAll
		broken = true
	endif
	if broken && reason <= 0 ;  "no reason"
		if is_slave
			reason = 9 ; "being a bad slave"
		else
			reason = 40 ; "being a bad slaver"
		endif
	endif
	if reason == 9 && !is_Slave
		reason = 40 ; "being a bad slaver"
	elseif reason == 40 && is_Slave
		reason = 9 ; "being a bad slave"
	endif
	; Additional behaviour corrections
	if reason == 13 && __should_be_respectful && !__was_respectful ; "being disrespectful"
		was_respectful = true
	elseif reason == 32 && __should_walk_on_four && !__is_walking_on_four ; "not walking on four"
		is_walking_on_four = true
	elseif reason == 5 && __should_be_silent && !was_silent ; "talking"
		was_silent = true
	endif

	LogTrace("TrainForReason reason="+reason+" severity="+severity)
	; Get punishment consequences from JSON
	string mod_check   = DOM01.GetJSONPunishmentTrainingCheckByIndex(reason)
	string mod_arousal = DOM01.GetJSONPunishmentArousalModifierByIndex(reason)
	string[] mod_stats = DOM01.GetJSONPunishmentTrainingStatsByIndex(reason)
	float[] mod_values = DOM01.GetJSONPunishmentTrainingValuesByIndex(reason)
	
	bool is_obedient
	if mod_check == ""
		is_obedient = true
	else
		float xcheck = GetTrainingByName(mod_check)
		if xcheck < 0.0
			LogTrace("TrainForReason: ERROR could not find stat to check for reason "+reason)
			if broken
				is_obedient = true
			else
				is_obedient = false
			endif
		elseif broken || RandomFloat() < xcheck
			is_obedient = true
		else
			is_obedient = false
		endif
	endif

	if is_obedient
		bool is_success = TrainFromArrays(severity,mod_arousal,mod_stats,mod_values)
		if !is_success
			LogTrace("TrainForReason: ERROR could not train for reason "+reason)
		endif
	else
		anger_factor += severity/10.0
	endif

	int n = DOM01.GetJSONNumberOfPunishmentReasons()
	if reason <= 0 ; "no reason" 
		anger_factor += severity * 0.05
		if broken || RandomFloat() < respect_training
			TrainSubmission(severity * 0.05)
			TrainHumiliation(severity * 0.05)
			TrainRespect(severity * 0.05)
			TrainAnger(severity * 0.05)
		endif
	elseif reason >= n
		SendNotification("Confusing "+GetMoodNameThirdPerson()+name+" UNREGISTERED REASON = "+reason+" "+DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex))	
		TrainResignation(severity * 0.05)
	endif
	if anger_factor > 0.0
		MakeAngryFor(anger_factor)
		anger_factor = 0.0
	endif
EndFunction

Function TrainForKink(float amount, int ikink)
	float severity = amount*20.0*DOM01.train_speed_kink
	LogTrace("TrainForKink reason="+ikink+" severity="+severity)
	; Get kink consequences from JSON
	string mod_arousal = DOM01.GetJSONKinkArousalModifierByIndex(ikink)
	string[] mod_stats = DOM01.GetJSONKinkTrainingStatsByIndex(ikink)
	float[] mod_values = DOM01.GetJSONKinkTrainingValuesByIndex(ikink)
	
	bool is_success = TrainFromArrays(severity,mod_arousal,mod_stats,mod_values)
	if !is_success
		LogTrace("TrainForKink: ERROR could not train for kink "+ikink)
	endif
	int n = DOM01.GetJSONNumberOfKinkReasons()
	if ikink <= 0 || ikink >= n ; "no kink" 
		SendNotification("Confusing "+GetMoodNameThirdPerson()+name+" UNREGISTERED KINK = "+ikink+" "+DOM01.GetJSONKinkReasonNameByIndex(ikink,actorSex))	
		TrainResignation(severity * 0.05)
	endif
EndFunction

Function TrainForPromiseOnEnd()
	;PrintTrainingBefore("promise end",1.0,promiseOath)
	if promiseOath == "money"
		if promise_kept > 0 ; Slave got more gifts 
			actor_alias.ChooseAnswerKeptPromise(PlayerRef)
			MakeFlatteredForGreed(5.0)
		else ; Slave got no gifts or gifts were taken from slave
			actor_alias.ChooseAnswerFailedPromise(PlayerRef)
			float amount = 1.0-(promise_kept as float)
			if amount < 5.0
				amount = 5.0
			elseif amount > 25.0
				amount = 25.0
			endif
			MakeAngryForTaken(amount)
		endif
	elseif promiseOath == "freedom"
		; there is no way this promise was kept...
		actor_alias.ChooseAnswerFailedPromise(PlayerRef)
		TrainResignation(5.0)
		MakeAngryFor(5.0)
	elseif promiseOath == "to be gentle"
		if promise_kept > 0 ; Praise/scold punishment was used
			actor_alias.ChooseAnswerKeptPromise(PlayerRef)
			float elapsed_time = GetCurrentGameTime()-promiseTimer
			if elapsed_time > 5.0 ; maximum 5 days have passed
				elapsed_time = 5.0
			endif
			TrainRespect(2.5*elapsed_time)
		elseif promise_kept < 0 ; Pain/rape punishment was used
			actor_alias.ChooseAnswerFailedPromise(PlayerRef)
			MakeAngryFor(5.0)
		else ; if promise_kept == 0 ; No punishment or praising
			float elapsed_time = GetCurrentGameTime()-promiseTimer
			if elapsed_time > 2.0 ; at least two days have passed
				actor_alias.ChooseAnswerKeptPromise(PlayerRef)
				TrainRespect(2.0)
			endif
		endif
	elseif promiseOath == "rapture"
		if promise_kept ; orgasm was reached
			actor_alias.ChooseAnswerKeptPromise(PlayerRef)
			TrainHumiliation(5.0)
		else
			actor_alias.ChooseAnswerFailedPromise(PlayerRef)
		endif
	elseif promiseOath == "to be sacrificed"
		if promise_kept ; actor should be dead by now...
			actor_alias.ChooseAnswerKeptPromise(PlayerRef)
			TrainFear(30.0)
			MakeAngryFor(20.0)
		else ; sacrifice was canceled!
			actor_alias.ChooseAnswerFailedPromise(PlayerRef)
			TrainFear(5.0)
			MakeAngryFor(5.0)
		endif
	elseif promiseOath == "pain"
		if promise_kept ; Pain/rape punishment was used
			actor_alias.ChooseAnswerKeptPromise(PlayerRef)
			TrainSubmission(5.0)
		else
			actor_alias.ChooseAnswerFailedPromise(PlayerRef)
			MakeAngryFor(5.0)
		endif
	endif
	;PrintTrainingAfter("promise",1.0,promiseOath)
EndFunction

Function TrainForBrokenSlave(DOM_Actor akVictimActor, float amount)		
	if !is_slave
		TrainSkillEnforcer(amount)
	else
		TrainSubmission(amount)
	endif
	number_of_brokenslaves += 1
EndFunction

Function TrainForRecruitedSlaver(DOM_Actor akVictimActor, float amount)		
	if !is_slave
		TrainSkillPersuader(amount)
	else
		TrainFear(amount)
	endif
	number_of_recruitedslavers += 1
EndFunction

Function TrainForWhoredSlave(DOM_Actor akVictimActor, float amount)		
	if !is_slave
		TrainSkillDepraver(amount)
	else
		TrainHumiliation(amount)
	endif
	number_of_whoredslaves += 1
EndFunction

Function TrainForCapturedSlave(DOM_Actor akVictimActor, float amount)	
	if !is_slave
		TrainSkillPredator(amount)
	else
		TrainAnger(amount)
	endif
	number_of_capturedslaves += 1
EndFunction

Function TrainForSoldSlave(DOM_Actor akVictimActor, float amount)		
	if !is_slave
		TrainSkillSlaver(amount)
	else
		TrainResignation(amount)
	endif
	number_of_soldslaves += 1
EndFunction

Function TrainForRansomedSlave(DOM_Actor akVictimActor, float amount)		
	if !is_slave
		TrainSkillDeceiver(amount)
	else
		TrainRespect(amount)
	endif
	number_of_ransomedslaves += 1
EndFunction

Function TrainForFriend(Float amount, int reason, string type, string friend_name, string rel)
	LogTrace("TrainForFriend reason="+reason+" type="+type+" rel="+rel)
	;PrintTrainingBefore("friend",1.0,DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex))
	if type == "scold"
		amount *= 0.5
	elseif !is_slave
		SendNotificationFriends(name+" approves of "+actorPossessive+" "+rel+" "+friend_name+"'s punishment")
	elseif reason <= 0 
		if MakeAngryForFriend(amount*0.5)
			SendNotificationFriends(name+" is angered by "+actorPossessive+" "+rel+" "+friend_name+"'s punishment")
		elseif MakeSadForFriend(amount*0.5)
			SendNotificationFriends(name+" is saddened by "+actorPossessive+" "+rel+" "+friend_name+"'s punishment")
		else
			SendNotificationFriends(name+" is impressed by "+actorPossessive+" "+rel+" "+friend_name+"'s punishment")
		endif
	elseif IsAngry()
		if MakeAngryForFriend(amount*0.25)
			SendNotificationFriends(name+" is angered by "+actorPossessive+" "+rel+" "+friend_name+"'s punishment")
		endif
	elseif MakeSadForFriend(amount*0.25)
		SendNotificationFriends(name+" is saddened by "+actorPossessive+" "+rel+" "+friend_name+"'s punishment")
	else
		SendNotificationFriends(name+" is impressed by "+actorPossessive+" "+rel+" "+friend_name+"'s punishment")
	endif
	TrainForReason(amount,reason)
	
	float multiplier
	if type == "pain"
		multiplier = 0.5
	elseif type == "sex"
		IncreaseArousal(5.0,MOD_Naivety)
	elseif type == "rape"
		IncreaseArousal(5.0,MOD_Naivety)
	elseif type == "public humiliation"
		multiplier = 1.0
	else
		multiplier = 0.25
	endif
	
	if RandomFloat() < MOD_Fearfulness*multiplier
		MakeAfraidFor(amount)
	elseif RandomFloat() < MOD_Prudent*multiplier
		MakeSadFor(amount)
	elseif RandomFloat() < MOD_Resentment*multiplier
		MakeAngryFor(amount)
	endif
	;PrintTrainingAfter("friend",1.0,DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex))
EndFunction

Function TrainForfreedom(Float base_amount)
	;LogTrace("TrainForfreedom: respect="+respect_training+" amount="+base_amount)
	TrainAnger(base_amount*MOD_Modesty*0.20)
	TrainRespect(base_amount*MOD_Modesty*0.15)
	TrainResignation(base_amount*MOD_Modesty*0.25)
EndFunction

Function TrainForGreed(Float base_amount)
	;LogTrace("TrainForGreed: respect="+respect_training+" amount="+base_amount)
	TrainAnger(base_amount*MOD_Greed*0.25)
	TrainRespect(base_amount*MOD_Greed*0.20)
	TrainSubmission(base_amount*MOD_Greed*0.15)
EndFunction

Function TrainForBondage(Float base_amount)
	TrainSubmission(base_amount*MOD_Flexibility*0.25)
	TrainPose(base_amount*MOD_Authority*0.20)
	TrainAnger(base_amount*MOD_Flexibility*0.15)
EndFunction

Function TrainForDiscipline(Float base_amount)
	TrainSubmission(base_amount*MOD_Discipline*0.25)
	TrainRespect(base_amount*MOD_Authority*0.20)
	TrainResignation(base_amount*MOD_Discipline*0.15)
EndFunction

Function TrainAll(Float amount)
	;PrintTrainingBefore("all",1.0,"spell")
	TrainSubmission(amount)
	TrainResignation(amount)
	TrainHumiliation(amount)
	TrainFear(amount)
	TrainRespect(amount)
	TrainAnger(amount)
	
	TrainAnal(amount)
	TrainOral(amount)
	TrainVaginal(amount)
	TrainPose(amount)
	TrainCombat(amount)

	number_of_shock   += 1
	number_of_praise  += 10
	number_of_pain    += 10
	number_of_toldoff += 10

	IncreaseArousal(amount,MOD_Daring)
	;PrintTrainingAfter("all",1.0,"spell")
EndFunction

; ### Individual training Functions ###

Function TrainSubmission(Float base_amount)
	;LogTrace("TrainSubmission amount="+base_amount+" submission="+submission+" love_desire="+love_desire)
	if submission < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(submission/100.0)))
		;LogTrace("TrainSubmission submission multiplier="+multiplier+" MOD_Humility="+MOD_Humility)
		submission += (multiplier*MOD_Humility*base_amount)
	elseif IsInLove()
		Float multiplier = 10.0/(love_desire*9.0+100.0) ; 0.1 + (0.9*(1.0-(love_desire/100.0)))
		;LogTrace("TrainSubmission love_desire multiplier="+multiplier+" MOD_Humility="+MOD_Humility)
		love_desire += (multiplier*MOD_Modesty*base_amount)*DOM01.train_speed_love*DOM01.DOMPlayerAlias.GetDeceiverModifier()
		IncreaseArousal(base_amount/10.0,MOD_Humility)
	endif
EndFunction

Function TrainFear(Float base_amount)
	if fear_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(fear_training/100.0)))
		fear_training += (multiplier*MOD_Fearfulness*base_amount)
	elseif IsDevoted()
		Float multiplier = 10.0/(loyal_worship*9.0+100.0) ; 0.1 + (0.9*(1.0-(loyal_worship/100.0)))
		loyal_worship += (multiplier*MOD_Dependence*base_amount)*DOM01.train_speed_love*DOM01.DOMPlayerAlias.GetDeceiverModifier()
	endif
EndFunction

Function TrainHumiliation(Float base_amount)
	if humiliation < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(humiliation/100.0)))
		humiliation += (multiplier*MOD_Naivety*base_amount)
	elseif IsInLove()
		Float multiplier = 10.0/(love_fascination*9.0+100.0) ; 0.1 + (0.9*(1.0-(love_fascination/100.0)))
		love_fascination += (multiplier*MOD_Ingenuity*base_amount)*DOM01.train_speed_love*DOM01.DOMPlayerAlias.GetDeceiverModifier()
		IncreaseArousal(base_amount/10.0,MOD_Naivety)
	endif
EndFunction

Function TrainAnger(Float base_amount)
	if anger_training < 100.0
		if base_amount > 0.0 ; anger training is boosted up by 25% because it is the only training going down
			base_amount *= 1.25
		endif
		Float multiplier = 0.1 + (0.9*(1.0-(anger_training/100.0)))
		anger_training += (multiplier*MOD_Forgiveness*base_amount)
	elseif IsDevoted() && base_amount > 0.0
		Float multiplier = 10.0/(loyal_absolution*9.0+100.0) ; 0.1 + (0.9*(1.0-(loyal_absolution/100.0)))
		loyal_absolution += (multiplier*MOD_Gentleness*base_amount)*DOM01.train_speed_love*DOM01.DOMPlayerAlias.GetDeceiverModifier()
	endif
EndFunction

Function TrainResignation(Float base_amount)
	if resignation < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(resignation/100.0)))
		resignation += (multiplier*MOD_Prudent*base_amount)
	elseif IsDevoted()
		Float multiplier = 10.0/(loyal_devotion*9.0+100.0) ; 0.1 + (0.9*(1.0-(loyal_devotion/100.0)))
		loyal_devotion += (multiplier*MOD_Consideration*base_amount)*DOM01.train_speed_love*DOM01.DOMPlayerAlias.GetDeceiverModifier()
	endif
EndFunction

Function TrainRespect(Float base_amount)
	;LogTrace("TrainRespect: respect="+respect_training+" amount="+base_amount)
	if respect_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(respect_training/100.0)))
		respect_training +=  (multiplier*MOD_Discipline*base_amount)
	elseif IsInLove()
		Float multiplier = 10.0/(love_admiration*9.0+100.0) ; 0.1 + (0.9*(1.0-(love_admiration/100.0)))
		love_admiration += (multiplier*MOD_Creativity*base_amount)*DOM01.train_speed_love*DOM01.DOMPlayerAlias.GetDeceiverModifier()
		IncreaseArousal(base_amount/10.0,MOD_Discipline)
	endif
EndFunction

Function TrainPose(Float base_amount)
	;LogTrace("Pose training for "+getName()+" amount="+base_amount)	
	if pose_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(pose_training/100.0)))
		pose_training +=  (multiplier*MOD_Flexibility*base_amount)
	endif
	actor_alias.UnregisterPose()
EndFunction

Function TrainHouse(Float base_amount)
	;SendNotificationAction("House training for "+getName())	
	if house_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(house_training/100.0)))
		house_training +=  (multiplier*MOD_Perfectionism*base_amount)
	endif
EndFunction

Function TrainWork(Float base_amount)
	;SendNotificationAction("Work training for "+getName())	
	if work_training < 100.0
		Float multiplier = 0.1 + (0.9*(1.0-(work_training/100.0)))
		work_training +=  (multiplier*MOD_Authority*base_amount)
	endif
EndFunction

Function TrainCombat(Float base_amount)
	;SendNotificationAction("Combat training for "+getName())	
	if IsDevoted()
		base_amount *= 2.0
	endif
	Float multiplier
	if combat_training < 50.0
		multiplier = 0.1 + (0.9*(1.0-(combat_training/100.0)))
	elseif combat_training >= 50.0
		multiplier = 0.1 + (0.9*(combat_training/100.0))
	endif
	combat_training += (multiplier*MOD_Combat*base_amount)
EndFunction

Function TrainVaginal(Float base_amount)
	;LogTrace("Vaginal training for "+getName()+" amount="+base_amount)	
	Float multiplier
	if vaginal_training < 100.0
		multiplier = 0.1 + (0.9*(1.0-(vaginal_training/100.0)))
		vaginal_training += (multiplier*MOD_Vaginal*base_amount)
	endif
EndFunction

Function TrainOral(Float base_amount)
	;LogTrace("Oral training for "+getName()+" amount="+base_amount)
	Float multiplier
	if oral_training < 100.0
		multiplier = 0.1 + (0.9*(1.0-(oral_training/100.0)))
		oral_training += (multiplier*MOD_Oral*base_amount)
	endif
EndFunction

Function TrainAnal(Float base_amount)
	;LogTrace("Anal training for "+getName()+" amount="+base_amount)	
	Float multiplier
	if anal_training < 100.0
		multiplier = 0.1 + (0.9*(1.0-(anal_training/100.0)))
		anal_training += (multiplier*MOD_Anal*base_amount)
	endif
EndFunction

Function TrainAllTrainer()
	TrainSkillPersuader(1.0)
	TrainSkillEnforcer(1.0)
	TrainSkillDepraver(1.0)
	TrainSkillPredator(1.0)
	number_of_trainee += 1
	SetNextPraiseReasonSilent(41) ; "being a good trainer"
	CheckAndRegisterKink(101,1.0) ; punishing slaves
	SetNextPraiseReasonSilent(51) ; "being a good sex trainer"
	CheckAndRegisterKink(102,1.0) ; training sex slaves
	
	if DOM01.staticTraitsMode
		return
	endif

	float xt  = (100.0-FACET_Wilfulness)*HEXACO_Conscientiousness/300.0
	if xt < 1.0
		xt = 1.0
	endif

	; -submi -honest +bold -open 
	xt *= 5.0/(number_of_trainee+5.0) ; less efficient after a few trainees
	HEXACO_Honesty      = HEXACO_Honesty      - RandomFloat(0, xt)
	HEXACO_eXtraversion = HEXACO_eXtraversion + RandomFloat(0, xt)
	FACET_Submissivity  = FACET_Submissivity  - RandomFloat(0, xt) 
	FACET_Sensuality    = FACET_Sensuality    + RandomFloat(0, xt)/2.0
	FACET_Boldness      = FACET_Boldness      + RandomFloat(0, xt)/2.0
EndFunction

Function TrainTrainer()
	TrainSkillPersuader(1.0)
	TrainSkillEnforcer(1.0)
	number_of_trainee += 1
	SetNextPraiseReasonSilent(41) ; "being a good trainer"
	CheckAndRegisterKink(101,1.0) ; punishing slaves
	
	if DOM01.staticTraitsMode
		return
	endif

	float xt  = (100.0-FACET_Wilfulness)*HEXACO_Conscientiousness/300.0
	if xt < 1.0
		xt = 1.0
	endif

	; -submi -honest +bold -open 
	xt *= 5.0/(number_of_trainee+5.0) ; less efficient after a few trainees
	HEXACO_Honesty      = HEXACO_Honesty      - RandomFloat(0, xt)
	HEXACO_eXtraversion = HEXACO_eXtraversion + RandomFloat(0, xt)
	FACET_Submissivity  = FACET_Submissivity  - RandomFloat(0, xt) 
	FACET_Sensuality    = FACET_Sensuality    + RandomFloat(0, xt)/2.0
	FACET_Boldness      = FACET_Boldness      + RandomFloat(0, xt)/2.0
EndFunction

Function TrainSexTrainer()
	TrainSkillDepraver(1.0)
	TrainSkillPredator(1.0)
	number_of_trainee += 1
	SetNextPraiseReasonSilent(51) ; "being a good sex trainer"
	CheckAndRegisterKink(102,1.0) ; training sex slaves
	
	if DOM01.staticTraitsMode
		return
	endif

	float xt  = (100.0-FACET_Wilfulness)*HEXACO_Conscientiousness/300.0
	if xt < 1.0
		xt = 1.0
	endif

	; -submi -honest +bold -open 
	xt *= 5.0/(number_of_trainee+5.0) ; less efficient after a few trainees
	HEXACO_Honesty      = HEXACO_Honesty      - RandomFloat(0, xt)
	HEXACO_eXtraversion = HEXACO_eXtraversion + RandomFloat(0, xt)
	FACET_Submissivity  = FACET_Submissivity  - RandomFloat(0, xt) 
	FACET_Sensuality    = FACET_Sensuality    + RandomFloat(0, xt)/2.0
	FACET_Boldness      = FACET_Boldness      + RandomFloat(0, xt)/2.0
EndFunction

Function TrainHouseMistress()
	TrainSkillSlaver(1.0)
	SetNextPraiseReasonSilent(42) ; "being a good housemistress"
	CheckAndRegisterKink(107,1.0) ; "managing slaves"
	TrainSkillDeceiver(1.0)
	number_of_trainer += 1
	
	if DOM01.staticTraitsMode
		return
	endif

	float xt  = (100.0-FACET_Wilfulness)*HEXACO_Conscientiousness/600.0
	if xt < 1.0
		xt = 1.0
	endif

	; -submi -honest +bold -open 
	xt *= 5.0/(number_of_trainer+5.0) ; less efficient after a few trainer successes
	HEXACO_Honesty      = HEXACO_Honesty      - RandomFloat(0, xt)
	HEXACO_eXtraversion = HEXACO_eXtraversion + RandomFloat(0, xt)/2.0
	HEXACO_Openness     = HEXACO_Openness     - RandomFloat(0, xt)/2.0
	FACET_Toughness     = FACET_Toughness     + RandomFloat(0, xt)
	FACET_Smartness     = FACET_Smartness     + RandomFloat(0, xt) 
EndFunction

; ### Combat & hit

Function HandlePunishmentOnHit(Actor akAbuser, Form akSource)
	if actor_alias.is_slapped ; Slap
		slap_pain_damage += 1
	elseif actor_alias.is_whipped ; Whip
		whip_pain_damage +=1
	elseif actor_alias.is_caned ; Cane
		cane_pain_damage +=1
	endif
	whipping_pain_damage += 1
	ticks_since_last_hit = 0
	end_punishment_on_next_tick = false
	OnExperiencePain()
EndFunction

bool bHasFought = false
Function HandleShouldHaveFought()
	;LogTrace("TestShouldhaveFought: is fighter=" + should_fight_for_player+" in combat="+PlayerRef.IsInCombat()+" has fought=" + bHasFought)
	actor_alias.CheckCombatStatus()

	if should_fight_for_player && (was_fighting || PlayerRef.IsInCombat() || PlayerRef.IsAlarmed() || akRef.IsInCombat() || akRef.IsAlarmed())
		;LogTrace("TestShouldhaveFought: is fighter=" + should_fight_for_player+" in combat="+PlayerRef.IsInCombat()+" has fought=" + bHasFought)
		;LogTrace("TestShouldhaveFought: can move=" +actor_alias.CanMove()+" fights="+was_fighting_for_player)
		;LogTrace("TestShouldhaveFought: is 3d loaded=" + akRef.Is3DLoaded()+" is tied="+akRef.IsInFaction(DOM01.DOMActionTied))
		if !actor_alias.canMove
			return
		endif
		if !akRef.Is3DLoaded() || akRef.IsInFaction(DOM01.DOMActionTied)
			return
		endif
		
		CheckIsFighting()
		if !was_fighting_for_player
			TrainAfterFailedToFight()
			RemoveNextPraiseReason(14) ; "being a good fighter"
			SetNextPraiseReasonSilent(15) ; "engaging in combat"
			if !HasNextPunishmentReason(14) ; "didnt_fight"
				SetNextPunishmentReasonOnceMessage(14,"does not feel like fighting") ; "didnt_fight"
			endif
		else
			bHasFought = true
		endif
		was_fighting = false
		;LogTrace("TestShouldhaveFought: hasFought set to " +bHasFought)
	elseif bHasFought
		;LogTrace("TestShouldhaveFought: is fighter=" + should_fight_for_player+" in combat="+PlayerRef.IsInCombat()+" has fought=" + bHasFought)
		;LogTrace("train after combat")
		TrainAfterCombat()
		bHasFought = false
	endif
EndFunction

Function TrainAfterFailedToFight()
	if actor_alias.has_dwarven_device
		if actor_alias.has_petsuit
			TrainCombat(1.25)
			TrainVaginal(0.75)
			TrainAnal(0.75)
		else
			TrainCombat(0.75)
			if actor_alias.has_plug_vaginal
				TrainVaginal(0.5)
			endif
			if actor_alias.has_plug_anal
				TrainAnal(0.5)
			endif
		endif
	else
		if actor_alias.has_petsuit || actor_alias.has_straitjacket
			TrainCombat(1.0)
		else
			TrainCombat(0.5)
		endif
		if actor_alias.has_plug_vaginal
			TrainVaginal(0.25)
		endif
		if actor_alias.has_plug_anal
			TrainAnal(0.25)
		endif
	endif
	
	MakeAngryFor(1.0)
EndFunction

Function TrainAfterCombat()
	SendNotificationAction(name+" has fought well")
	if HasNextPunishmentReason(14) ; "didnt_fight"
		SetNextPraiseReasonSilent(15) ; "engaging in combat"
		if IsDevoted()
			IncreaseArousal(2.0,MOD_Hope)
		endif
	else
		SetNextPraiseReasonSilent(14) ; "being a good fighter"
		if IsDevoted()
			IncreaseArousal(4.0,MOD_Daring)
		endif
	endif

	if actor_alias.has_dwarven_device
		if actor_alias.has_petsuit
			TrainCombat(2.5)
			TrainVaginal(0.5)
			TrainAnal(0.5)
		else
			TrainCombat(1.5)
			if actor_alias.has_plug_vaginal
				TrainVaginal(0.25)
			endif
			if actor_alias.has_plug_anal
				TrainAnal(0.25)
			endif
		endif
	else
		if actor_alias.has_petsuit || actor_alias.has_straitjacket
			TrainCombat(2.0)
		else
			TrainCombat(1.0)
		endif
		if actor_alias.has_plug_vaginal
			TrainVaginal(0.125)
		endif
		if actor_alias.has_plug_anal
			TrainAnal(0.125)
		endif
	endif
	if actor_alias.is_naked
		TrainCombat(1.0) ; extra training if naked
	endif

	TrainAnger(1.0)
EndFunction

Function RegisterCombatEvents()
	UpdateCombatActorValues()
	actor_alias.RegisterForWhistleEvents()
EndFunction

Function UnregisterCombatEvents()
	akRef.SetActorValue("aggression", 0.0)
	akRef.SetActorValue("assistance", default_assistance)
	akRef.SetActorValue("morality",   0.0)
	akRef.SetActorValue("confidence", 4.0)
	actor_alias.UnregisterForWhistleEvents()
EndFunction
	
Function UpdateCombatActorValues()
	; Update combat actor values
	akRef.SetActorValue("aggression", 1.0)
	akRef.SetActorValue("assistance", 2.0)
	akRef.SetActorValue("morality",   0.0)

	if default_confidence >= 4.0 || combat_training >= 60.0
		akRef.SetActorValue("confidence", 4.0)
	elseif default_confidence >= 3.0 || combat_training >= 40.0 || IsInLove()
		akRef.SetActorValue("confidence", 3.0)
	elseif default_confidence >= 2.0 || combat_training >= 20.0 || IsDevoted()
		akRef.SetActorValue("confidence", 2.0)
	else
		akRef.SetActorValue("confidence", 1.0)
	endif	
EndFunction

Function UpdateCombatStrength(float initialTraining)
	if is_player_actor
		return
	endif
	bool update_needed = false
	
	if actorLevel < PlayerRef.GetLevel()
		update_needed = true
	endif

	if (initialTraining / 10.0) as Int < (__combat_training / 10.0) as Int
		UpdateCombatActorValues()
		update_needed = true
	endif

	if !update_needed
		return
	endif
	
	UpdateCombatStrengthToPlayerLevel()
EndFunction

Function SetBaseActorValue(string val_name, float value)
	LogTrace("SetBaseActorValue start "+val_name+" val="+value+" was="+akRef.GetBaseActorValue(val_name))
	akRef.SetActorValue(val_name,value)
	LogTrace("SetBaseActorValue end "+val_name+" val="+value+" now="+akRef.GetBaseActorValue(val_name))
EndFunction

Function RegenHealth(float xregen)
	if is_player_actor
		return
	endif
	float cur_health = akRef.GetActorValue("Health")
	float base_health = akRef.GetBaseActorValue("Health")
	if base_health <= 0.0 ; Check
		base_health = 100.0 + 3.33*(actorLevel - 1.0)
		SetBaseActorValue("Health", base_health)
	endif
	if cur_health <= 0.0 
		cur_health = 1.0
	endif
	if cur_health >= base_health
		return
	endif
	float hregen = xregen * base_health / 1000.0
	LogTrace("RegenHealth start cur_health="+cur_health+" base="+base_health+" regen="+hregen)
	akRef.RestoreActorValue("Health", hregen) ; Regen health
	LogTrace("RegenHealth end cur_health="+akRef.GetActorValue("Health")+" base="+akRef.GetBaseActorValue("Health")+" regen="+hregen)
EndFunction

Function RestoreHealth()
	if is_player_actor
		return
	endif
	float cur_health = akRef.GetActorValue("Health")
	float base_health = akRef.GetBaseActorValue("Health")
	if base_health <= 0.0 ; Check
		base_health = 100.0 + 3.33*(actorLevel - 1.0)
		SetBaseActorValue("Health", base_health)
	endif
	if cur_health <= 0.0 
		cur_health = 1.0
	endif
	if cur_health >= base_health
		return
	endif
	LogTrace("RestoreHealth start cur_health="+cur_health+" base="+base_health)
	akRef.RestoreActorValue("Health", base_health) ; Restore health
	LogTrace("RestoreHealth end cur_health="+akRef.GetActorValue("Health")+" base="+akRef.GetBaseActorValue("Health"))
EndFunction

Function DamageHealth()
	if is_player_actor
		return
	endif
	float curr_health = akRef.GetActorValue("Health")
	akRef.DamageActorValue("Health", curr_health - 1.0) ; Set current health to minimum
EndFunction

float Function GetBaseHealth()
	float base_health = akRef.GetBaseActorValue("Health")
	if is_player_actor
		return base_health
	endif
	if base_health <= 0.0 ; Check
		base_health = 100.0 + 3.33*(actorLevel - 1.0)
		SetBaseActorValue("Health", base_health)
	endif
	LogTrace("GetBaseHealth health="+base_health+" base="+akRef.GetBaseActorValue("Health"))
	return base_health
EndFunction

Function UpdateHealth(int currentLevel, int addLevel)
	float baseHealth = akRef.GetBaseActorValue("Health")
	if baseHealth <= 0.0 ; Check
		baseHealth = 100.0 + 3.33*(currentLevel - 1.0)
		SetBaseActorValue("Health", baseHealth)
	endif
	
	float addHealth = (baseHealth - 100.0) / currentLevel
	if addHealth < 3.33
		addHealth = 3.33
	endif
	float newHealth = baseHealth + addHealth*addLevel
	if newHealth > baseHealth
		SetBaseActorValue("Health",newHealth)
	endif
	LogTrace("UpdateHealth old="+baseHealth+" new="+akRef.GetBaseActorValue("Health"))
EndFunction

Function UpdateStamina(int currentLevel, int addLevel)
	float baseStamina = akRef.GetBaseActorValue("Stamina")
	if baseStamina <= 0.0
		baseStamina = 100.0 + 3.33*(currentLevel - 1.0)
		SetBaseActorValue("Stamina",baseStamina)
	endif
	
	float addStamina = (baseStamina - 100.0) / currentLevel
	if addStamina < 3.33
		addStamina = 3.33
	endif
	float newStamina = baseStamina + addStamina*addLevel
	if newStamina > baseStamina
		SetBaseActorValue("Stamina",newStamina)
	endif
	LogTrace("UpdateStamina old="+baseStamina+" new="+akRef.GetBaseActorValue("Stamina"))
EndFunction

Function UpdateMagicka(int currentLevel, int addLevel)
	float baseMagicka = akRef.GetBaseActorValue("Magicka")
	if baseMagicka <= 0.0
		return
	endif
	
	float addMagicka = (baseMagicka - 50.0) / currentLevel
	if addMagicka < 3.33
		addMagicka = 3.33
	endif
	float newMagicka = baseMagicka + addMagicka*addLevel
	if newMagicka > baseMagicka
		SetBaseActorValue("Magicka",newMagicka)
	endif
	LogTrace("UpdateMagicka old="+baseMagicka+" new="+akRef.GetBaseActorValue("Magicka"))
EndFunction

Function UpdateSkill(string the_skill, int currentLevel, int addLevel)
	float baseSkill = akRef.GetBaseActorValue(the_skill)
	if baseSkill <= 0.0
		return
	endif
	if baseSkill >= 100.0
		return
	endif
	
	float addSkill = baseSkill / currentLevel
	if addSkill < 1.0
		addSkill = 1.0
	elseif addSkill > 10.0
		addSkill = 10.0
	endif
	float newSkill = baseSkill + addSkill * addLevel
	if newSkill > 100.0
		newSkill = 100.0
	endif
	if newSkill > baseSkill
		SetBaseActorValue(the_skill,newSkill)
	endif
	LogTrace("UpdateMagicka "+the_skill+" old="+baseSkill+" new="+akRef.GetBaseActorValue(the_skill))
EndFunction

int Function GetActorLevel()
	int base_level   = akRef.getLevel()
	if combat_training <= 0.0
		return base_level
	endif
	int player_level = PlayerRef.getLevel()
	if base_level < player_level
		return (base_level + (player_level-base_level)/player_level * combat_training / 100.0) as int
	endif
	if combat_training > 100.0
		return (base_level * combat_training / 100.0) as int
	endif
	return base_level
EndFunction

Function UpdateCombatStrengthToPlayerLevel()
	if !DOM01.UpdateCombatStrength
		return
	endif

	int currentLevel = actorLevel
	actorLevel = GetActorLevel()
	LogTrace("UpdateCombatStrengthToPlayerLevel check current level="+currentLevel+" new level="+actorLevel)
	if currentLevel >= actorLevel
		return
	endif
	; Stats 100 (50 for Magicka) + 10 per level
	int combatLevel = actorLevel - currentLevel
	if combatLevel == 1
		SendNotification(name+" has gained a level!")
	else
		SendNotification(name+" has gained "+combatLevel+" levels!")
	endif
	
	; Attributes
	LogTrace("UpdateCombatStrengthToPlayerLevel start currentLevel="+currentLevel+" Health base="+akRef.GetBaseActorValue("Health"))
	UpdateHealth( currentLevel,combatLevel)
	UpdateMagicka(currentLevel,combatLevel)
	UpdateStamina(currentLevel,combatLevel)	
	
	; Skills
	UpdateSkill("OneHanded",   currentLevel, combatLevel)
	UpdateSkill("TwoHanded",   currentLevel, combatLevel)
	UpdateSkill("Marksman",    currentLevel, combatLevel)
	UpdateSkill("Block",       currentLevel, combatLevel)
	UpdateSkill("Smithing",    currentLevel, combatLevel)
	UpdateSkill("HeavyArmor",  currentLevel, combatLevel)
	UpdateSkill("LightArmor",  currentLevel, combatLevel)
	UpdateSkill("Pickpocket",  currentLevel, combatLevel)
	UpdateSkill("Lockpicking", currentLevel, combatLevel)
	UpdateSkill("Sneak",       currentLevel, combatLevel)
	UpdateSkill("Alchemy",     currentLevel, combatLevel)
	UpdateSkill("Speechcraft", currentLevel, combatLevel)
	UpdateSkill("Alteration",  currentLevel, combatLevel)
	UpdateSkill("Conjuration", currentLevel, combatLevel)
	UpdateSkill("Destruction", currentLevel, combatLevel)
	UpdateSkill("Illusion",    currentLevel, combatLevel)
	UpdateSkill("Restoration", currentLevel, combatLevel)
	UpdateSkill("Enchanting",  currentLevel, combatLevel)
	LogTrace("UpdateCombatStrengthToPlayerLevel end actorLevel="+actorLevel+" base="+akRef.GetBaseActorValue("Health"))
EndFunction

; ### Life style orders

Function SetShouldFightForPlayer()
	SendNotificationOrder(name+" will fight with you")
	should_fight_for_player = true
	actor_alias.SetTraineesToFight(true)
EndFunction

Function UnsetShouldFightForPlayer()
	SendNotificationOrder(name+" will not engage in combat")
	should_fight_for_player = false
	actor_alias.SetTraineesToFight(false)
EndFunction

bool __should_fight_for_player = false
bool Property should_fight_for_player Hidden
	bool Function get()
		return __should_fight_for_player
	EndFunction
	Function set(bool value)
		if value
			if !is_player_actor
				actor_alias.UnSetCombatPackageOverride() ; allow combat package to run
				RegisterCombatEvents()
			endif
		else
			if !is_player_actor
				UnregisterCombatEvents()
				actor_alias.SetCombatPackageOverride() ; avoid combat package to run
				if mood != "just_captured" && !is_walking_on_four
					LogTrace("should_fight_for_player Anim_IdleReset")
					actor_alias.Anim_IdleReset() ; Would mess pose at capture
				endif
			endif
		endif
		if value != __should_fight_for_player
			__should_fight_for_player = value
			CheckIsFighting()
			SetBoolFaction(akRef, DOM01.DOMShouldFightForPlayer, __should_fight_for_player)
			akRef.AddToFaction(DOM01.DunPlayerAllyFaction)
			DOM01.DOM04.NotifyChangeCombat(actor_alias)
		else
			CheckIsFighting()
			SetBoolFaction(akRef, DOM01.DOMShouldFightForPlayer, __should_fight_for_player)
			akRef.AddToFaction(DOM01.DunPlayerAllyFaction)
		endif
	EndFunction
EndProperty

bool __should_be_respectful = false
bool Property should_be_respectful Hidden
	bool Function get()
		return __should_be_respectful
	EndFunction
	Function set(bool value)
		__should_be_respectful = value
		was_respectful = true
		SetBoolFaction(akRef, DOM01.DOMShouldBeRespectful, __should_be_respectful)
		if value 
			IncreaseArousal(5.0, MOD_Discipline)
			DOM01.DOM04.NotifyRespect(actor_alias,"respectful","should be respectful",true)
		else
			DOM01.DOM04.NotifyRespect(actor_alias,"respectful","should not be respectful",false)
		endif
	EndFunction
EndProperty

bool __was_respectful = false
bool Property was_respectful Hidden
	bool Function get()
		return __was_respectful
	EndFunction
	Function set(bool value)
		__was_respectful = value
		SetBoolFaction(akRef, DOM01.DOMIsRespectful, __was_respectful)
	EndFunction
EndProperty

bool __should_walk_on_four = false
bool Property should_walk_on_four Hidden
	bool Function get()
		return __should_walk_on_four
	EndFunction
	Function set(bool value)
		if value == __should_walk_on_four
			return
		endif
		__should_walk_on_four = value
		if DOM01.DOMShouldWalkOnFour == None
			LogTrace("Initialize: Check  DOMShouldWalkOnFour="+DOM01.DOMShouldWalkOnFour)
			DOM01.DOMShouldWalkOnFour = Game.GetFormFromFile(0x000EF973, "DiaryOfMine.esm") As Faction
			LogTrace("Initialize: Assign DOMShouldWalkOnFour="+DOM01.DOMShouldWalkOnFour)
		endif
		if DOM01.DOMIsWalkingOnFour == None
			LogTrace("Initialize: Check  DOMIsWalkingOnFour="+DOM01.DOMIsWalkingOnFour)
			DOM01.DOMIsWalkingOnFour = Game.GetFormFromFile(0x000EF972, "DiaryOfMine.esm") As Faction
			LogTrace("Initialize: Assign DOMIsWalkingOnFour="+DOM01.DOMIsWalkingOnFour)
		endif

		SetBoolFaction(akRef, DOM01.DOMShouldWalkOnFour, __should_walk_on_four)
		is_walking_on_four    = value
		if value 
			IncreaseArousal(5.0, MOD_Discipline)
			DOM01.DOM04.NotifyWalkOnFour(actor_alias,"walking","should walk on four",true)
		else
			DOM01.DOM04.NotifyWalkOnFour(actor_alias,"walking","should not walk on four",false)
		endif
		LogTrace("should_walk_on_four="+__should_walk_on_four+" faction="+akRef.IsInFaction(DOM01.DOMShouldWalkOnFour)+" "+DOM01.DOMShouldWalkOnFour)
		LogTrace("is_walking_on_four="+__is_walking_on_four+" faction="+akRef.IsInFaction(DOM01.DOMIsWalkingOnFour)+" "+DOM01.DOMIsWalkingOnFour)
	EndFunction
EndProperty

bool __is_walking_on_four = false
bool Property is_walking_on_four Hidden
	bool Function get()
		return __is_walking_on_four
	EndFunction
	Function set(bool value)
		if value == __is_walking_on_four
			return
		endif
		__is_walking_on_four = value
		SetBoolFaction(akRef, DOM01.DOMIsWalkingOnFour, __is_walking_on_four)
		if !__is_walking_on_four
			;actor_alias.Anim_IdleReset()
			Debug.SendAnimationEvent(akRef,"IdleForceDefaultState")
		endif
		;LogTrace("is_walking_on_four Anim_IdleReset value="+__is_walking_on_four+" faction="+akRef.IsInFaction(DOM01.DOMIsWalkingOnFour))
	EndFunction
EndProperty

bool Function IsRespectfulWritings()
	if !is_slave
		return true
	endif
	if !should_be_respectful
		if IsDevoted() || IsBrokenToObey()
			return true
		endif
		return false
	endif
	return !(IsNotRespectfullyWriting(1.0))
EndFunction

Function SetShouldBeSilent()
	SendNotificationOrder(name+" will try to be silent")
	should_be_silent = true
	DOM01.DOM04.NotifySilent(actor_alias,"silent","should be silent",true)
EndFunction

Function UnsetShouldBeSilent()
	SendNotificationOrder(name+" is now allowed to speak")
	should_be_silent = false
	DOM01.DOM04.NotifySilent(actor_alias,"silent","should not be silent",false)
EndFunction

bool __should_be_silent = false
bool Property should_be_silent Hidden
	bool Function get()
		return __should_be_silent
	EndFunction
	Function set(bool value)
		__should_be_silent = value
		was_silent = true
		SetBoolFaction(akRef, DOM01.DOMShouldBeSilent, __should_be_silent)
	EndFunction
EndProperty

bool __should_be_noorgasm = false
bool Property should_be_noorgasm Hidden
	bool Function get()
		return __should_be_noorgasm
	EndFunction
	Function set(bool value)
		__should_be_noorgasm = value
		was_allowed_toorgasm = false
		SetBoolFaction(akRef, DOM01.DOMShouldBeNoOrgasm, __should_be_noorgasm)
		if value
			DOM01.DOM04.NotifyOrgasmControl(actor_alias,"orgasm control","is subject to orgasm control",true)
		else
			DOM01.DOM04.NotifyOrgasmControl(actor_alias,"orgasm control","is not subject to orgasm control",false)
		endif
	EndFunction
EndProperty

bool __was_should_be_naked = false
bool __was_should_hold_weapons = false
bool __was_should_wear_armor = false

Function UndressBeforeSex(Actor akAbuser, bool do_aggro)
	__was_should_be_naked = __should_be_naked
	__was_should_hold_weapons = __should_hold_weapons
	__was_should_wear_armor = __should_wear_armor
	if __should_hold_weapons
		should_hold_weapons = false
	endif
	if __should_wear_armor
		should_wear_armor = false
	endif
	if !DOM01.DOMSexlab.undressBeforeSex
		return
	endif
	should_be_naked = true
	if actor_alias.is_naked
		return
	endif
	LogTrace("UndressBeforeSex agressor="+akAbuser+" aggro="+do_aggro+" anim="+DOM01.doAnimBeforeAndAfterSex)
	if do_aggro && DOM01.DOMSexlab.doRipOffBeforeSex && !IsObedient()
		if DOM01.doAnimBeforeAndAfterSex
			actor_alias.Interact_Undress(akAbuser)
		else
			actor_alias.Interact_UndressNoAnim(akAbuser)
		endif
	elseif DOM01.doAnimBeforeAndAfterSex
		actor_alias.Interact_StripNoChoice(akAbuser,true)
	else
		actor_alias.Interact_StripNoChoice(akAbuser,false)
	endif
	;actor_alias.SendOrderEquipInventoryQuiet(false) ; anim is already taken care of ; strip already took care of equipment and applied effects
EndFunction

Function RedressAfterSex(Actor akAbuser)
	LogTrace("RedressAfterSex agressor="+akAbuser+" anim="+DOM01.doAnimBeforeAndAfterSex)
	LogTrace("RedressAfterSex was_should_be_naked="+__was_should_be_naked+" was_should_wear_armor="+__was_should_wear_armor+" was_should_hold_weapons="+__was_should_hold_weapons)
	LogTrace("RedressAfterSex should_be_naked="+should_be_naked+" should_wear_armor="+should_wear_armor+" should_hold_weapons="+should_hold_weapons)
	if __was_should_hold_weapons
		should_hold_weapons = true
	endif
	if __was_should_wear_armor
		should_wear_armor = true
	endif
	if !DOM01.DOMSexlab.redressAfterSex ; keep should be naked status
		if __was_should_wear_armor || __was_should_hold_weapons
			actor_alias.TryWearClothes(DOM01.doAnimBeforeAndAfterSex)
		endif
		return
	endif
	if !__was_should_be_naked
		should_be_naked = false
	endif
	actor_alias.was_inventory_changed = true
	actor_alias.SendOrderEquipInventory(DOM01.doAnimBeforeAndAfterSex) ; with or without anim
EndFunction

Function UndressBeforeShowering()
	LogTrace("UndressBeforeShowering")
	__was_should_be_naked = __should_be_naked
	__was_should_hold_weapons = __should_hold_weapons
	__was_should_wear_armor = __should_wear_armor
	if __should_hold_weapons
		should_hold_weapons = false
	endif
	if __should_wear_armor
		should_wear_armor = false
	endif
	if actor_alias.is_naked
		return
	endif
	should_be_naked = true
	actor_alias.Interact_StripNoChoice(None,true)
	;actor_alias.SendOrderEquipInventoryQuiet(false) ; anim is already taken care of ; strip already took care of equipment and applied effects
EndFunction

Function RedressAfterShowering()
	LogTrace("RedressAfterShowering")
	if __was_should_hold_weapons
		should_hold_weapons = true
	endif
	if __was_should_wear_armor
		should_wear_armor = true
	endif
	if !__was_should_be_naked
		should_be_naked = false
	endif
	actor_alias.was_inventory_changed = true
	actor_alias.SendOrderEquipInventory(true) ; with anim
EndFunction

bool __should_be_naked = false
bool Property should_be_naked Hidden
	bool Function get()
		;if actor_alias.is_running_away
		;	return false
		;endif
		return __should_be_naked
	EndFunction
	Function set(bool value)
		LogTrace("should_be_naked = "+__should_be_naked+" to "+value+" faction="+akRef.IsInFaction(DOM01.DOMShouldBeNaked))
		__should_be_naked = value
		actor_alias.was_inventory_changed = true
		SetBoolFaction(akRef, DOM01.DOMShouldBeNaked, __should_be_naked)
		SetAllowGearFaction()
	EndFunction
EndProperty

bool __should_wear_armor = true
bool Property should_wear_armor Hidden
	bool Function get()
		;if actor_alias.is_running_away
		;	return true
		;endif
		return __should_wear_armor
	EndFunction
	Function set(bool value)
		LogTrace("should_wear_armor = "+__should_wear_armor+" to "+value+" faction="+akRef.IsInFaction(DOM01.DOMShouldWearArmor))
		__should_wear_armor = value
		actor_alias.was_inventory_changed = true
		SetBoolFaction(akRef, DOM01.DOMShouldWearArmor, __should_wear_armor)
	EndFunction
EndProperty

bool __should_hold_weapons = false
bool Property should_hold_weapons Hidden
	bool Function get()
		;if actor_alias.is_running_away
		;	return true
		;endif
		if __should_fight_for_player
			return true
		endif
		if akRef.IsInFaction(DOM01.DOMPlayerEnemyFaction)
			return true
		endif
		return __should_hold_weapons
	EndFunction
	Function set(bool value)
		;LogTrace("should_hold_weapons = "+value)
		__should_hold_weapons = value
		actor_alias.was_inventory_changed = true
		SetBoolFaction(akRef, DOM01.DOMShouldHoldWeapons, __should_hold_weapons)
	EndFunction
EndProperty

Function SetShouldBeNakedSoft(bool value = true)
	;actor_alias.was_inventory_changed = true
	LogTrace("SOFT should_be_naked = "+__should_be_naked+" to "+value+" faction="+akRef.IsInFaction(DOM01.DOMShouldBeNaked))
	__should_be_naked = value
	SetBoolFaction(akRef, DOM01.DOMShouldBeNaked, __should_be_naked)
	SetAllowGearFaction()
EndFunction

bool was_fighting = false
Function UpdateIsFighting(Actor akTarget, int aeCombatStatus)
	if aeCombatStatus == 0 || akTarget == None
		return
	endif
	if akTarget == PlayerRef || akTarget.IsInFaction(DOM01.DOMActorFaction)
		return
	endif
	was_fighting = true
	SetNextPraiseReasonSilent(15) ; being a good fighter
EndFunction

Function CheckIsFighting()
	if !should_fight_for_player
		was_fighting_for_player = false
		return
	endif
	if IsDevoted()
		was_fighting_for_player = true
		return
	endif
	if actor_alias.behaviour == "running_away"
		was_fighting_for_player = false
		return
	endif
	float chance = __chance_fighting*(1.0+ (__chance_recently_punished * 0.8))
	if RandomFloat() < chance
		was_fighting_for_player = true
		return
	endif
	was_fighting_for_player = false
EndFunction

bool __was_fighting_for_player = true 
bool Property was_fighting_for_player Hidden
	bool Function get()
		return __was_fighting_for_player
	EndFunction
	Function set(bool value)
		__was_fighting_for_player = value
		if __was_fighting_for_player
			akRef.RemoveFromFaction(DOM01.DOMFailedToFight)
		else
			akRef.SetFactionRank(DOM01.DOMFailedToFight,1)
		endif
	EndFunction
EndProperty

bool was_silent = true
bool Property was_allowed_toorgasm = false Auto Hidden

Function CheckWasAllowedToOrgasm()
	;LogTrace("CheckWasAllowedToOrgasm "+should_be_noorgasm+" "+had_orgasm)
	if akRef.GetFactionRank(DOM01.DOMActionTraining) == 3
		SetNextPraiseReasonSilent(52) ; "being a lustful trainer"
	endif
	if !should_be_noorgasm
		SetNextPraiseReasonSilent(20) ; "being a lustful pet"
		return
	endif
	if was_allowed_toorgasm
		SetNextPraiseReasonSilent(29) ; "orgasming when ordered"
	elseif akRef.GetFactionRank(DOM01.DOMActionTraining) != 3
		SetNextPunishmentReasonSilent(27) ; "orgasming"
	endif
	CheckAndRegisterKink(73,2.0) ; "being subject to orgasm control"
EndFunction

; ### Counters and new experiences

int Function GetNewSexualExperiences()
	int n = 0
	if virgin_status_vaginal == 2
		n += 1
	endif
	if virgin_status_oral == 2
		n += 1
	endif
	if virgin_status_anal == 2
		n += 1
	endif
	if virgin_status_same == 2
		n += 1
	endif
	if virgin_status_gang == 2
		n += 1
	endif
	return n
EndFunction

int __new_sexual_experiences = 0
int Property new_sexual_experiences Hidden
	int Function get()
		return __new_sexual_experiences
	EndFunction
	Function set(int value)
		;LogTrace("new_sexual_experiences.Set() = "+value)
		if __new_sexual_experiences == value
			return
		endif
		__new_sexual_experiences = value
		if __new_sexual_experiences < 0
			__new_sexual_experiences = 0
		endif
		; Update dependencies
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInLove()
	EndFunction
EndProperty

; Virgin status
; 0 = Virgin
; 1 = Soon not a virgin anymore
; 2 = Player took virginity
; 3 = Someone else took virginity
; 4 = Not a virgin since a long time ago
int __virgin_status_vaginal = 0
int Property virgin_status_vaginal Hidden
	int Function get()
		;LogTrace("virgin_status_vaginal.Get() : "+name+" = "+__virgin_status_vaginal)	
		return __virgin_status_vaginal
	EndFunction
	Function set(int value)
		;LogTrace("virgin_status_vaginal.Set() = "+value)	
		if __virgin_status_vaginal == value
			return
		endif
		if value == 0
			DOM01.DOMSexlab.SetStat(akRef, "Vaginal",0)
			DOM01.DOMSexlab.SetStat(akRef, "VaginalCount",0)
		endif
		__virgin_status_vaginal = value
		if __virgin_status_vaginal < 0
			__virgin_status_vaginal = 0
		endif
		if __virgin_status_vaginal < 127
			akRef.SetFactionRank(DOM01.DOMVirginVaginal, __virgin_status_vaginal)
		else
			akRef.SetFactionRank(DOM01.DOMVirginVaginal, 127)
		endif
		; Update dependencies
		new_sexual_experiences = GetNewSexualExperiences()
	EndFunction
EndProperty

int __virgin_status_oral = 0
int Property virgin_status_oral Hidden
	int Function get()
		;LogTrace("virgin_status_oral.Get() : "+name+" = "+__virgin_status_oral)	
		return __virgin_status_oral
	EndFunction
	Function set(int value)
		;LogTrace("virgin_status_oral.Set() = "+value)	
		if __virgin_status_oral == value
			return
		endif
		if value == 0
			DOM01.DOMSexlab.SetStat(akRef, "Oral",0)
			DOM01.DOMSexlab.SetStat(akRef, "OralCount",0)
		endif
		__virgin_status_oral = value
		if __virgin_status_oral < 0
			__virgin_status_oral = 0
		endif
		if __virgin_status_oral < 127
			akRef.SetFactionRank(DOM01.DOMVirginOral, __virgin_status_oral)
		else
			akRef.SetFactionRank(DOM01.DOMVirginOral, 127)
		endif
		; Update dependencies
		new_sexual_experiences = GetNewSexualExperiences()
	EndFunction
EndProperty

int __virgin_status_anal = 0
int Property virgin_status_anal Hidden
	int Function get()
		;LogTrace("virgin_status_anal.Get() : "+name+" = "+__virgin_status_anal)	
		return __virgin_status_anal
	EndFunction
	Function set(int value)
		;LogTrace("virgin_status_anal.Set() = "+value)	
		if __virgin_status_anal == value
			return
		endif
		if value == 0
			DOM01.DOMSexlab.SetStat(akRef, "Anal",0)
			DOM01.DOMSexlab.SetStat(akRef, "AnalCount",0)
		endif
		__virgin_status_anal = value
		if __virgin_status_anal < 0
			__virgin_status_anal = 0
		endif
		if __virgin_status_anal < 127
			akRef.SetFactionRank(DOM01.DOMVirginAnal, __virgin_status_anal)
		else
			akRef.SetFactionRank(DOM01.DOMVirginAnal, 127)
		endif
		; Update dependencies
		new_sexual_experiences = GetNewSexualExperiences()
	EndFunction
EndProperty

int __virgin_status_same = 0
int Property virgin_status_same Hidden
	int Function get()
		;LogTrace("virgin_status_same.Get() : "+name+" = "+__virgin_status_same)	
		return __virgin_status_same
	EndFunction
	Function set(int value)
		;LogTrace("virgin_status_same.Set() = "+value)	
		if __virgin_status_same == value
			return
		endif
		if value == 0
			bool isFemale = ((actorSex%2) == 1)
			DOM01.DOMSexlab.ResetSexuality(akRef,isFemale)
		endif
		__virgin_status_same = value
		if __virgin_status_same < 0
			__virgin_status_same = 0
		endif
		if __virgin_status_same < 127
			akRef.SetFactionRank(DOM01.DOMVirginSame, __virgin_status_same)
		else
			akRef.SetFactionRank(DOM01.DOMVirginSame, 127)
		endif
		; Update dependencies
		new_sexual_experiences = GetNewSexualExperiences()
	EndFunction
EndProperty

int __virgin_status_gang = 0
int Property virgin_status_gang Hidden
	int Function get()
		;LogTrace("virgin_status_gang.Get() : "+name+" = "+__virgin_status_gang)	
		return __virgin_status_gang
	EndFunction
	Function set(int value)
		;LogTrace("virgin_status_gang.Set() = "+value)	
		if __virgin_status_gang == value
			return
		endif
		__virgin_status_gang = value
		if __virgin_status_gang < 0
			__virgin_status_gang = 0
		endif
		if __virgin_status_gang < 127
			akRef.SetFactionRank(DOM01.DOMVirginGangbang, __virgin_status_gang)
		else
			akRef.SetFactionRank(DOM01.DOMVirginGangbang, 127)
		endif
		; Update dependencies
		new_sexual_experiences = GetNewSexualExperiences()
	EndFunction
EndProperty

Function ResetSexLabStats()
	if __virgin_status_same == 0 && __virgin_status_anal == 0 && __virgin_status_oral == 0 && __virgin_status_vaginal == 0
		DOM01.DOMSexlab.ClearStats(akRef)
		number_of_rape = 0
		number_of_sex = 0
		number_of_sexformoney = 0
		number_of_sexwithothers = 0
		number_of_orgasm = 0
		virgin_status_gang = 0
		return
	endif
	if __virgin_status_vaginal == 0
		DOM01.DOMSexlab.SetStat(akRef, "Vaginal",0)
		DOM01.DOMSexlab.SetStat(akRef, "VaginalCount",0)
	endif
	if __virgin_status_oral == 0
		DOM01.DOMSexlab.SetStat(akRef, "Oral",0)
		DOM01.DOMSexlab.SetStat(akRef, "OralCount",0)
	endif
	if __virgin_status_anal == 0
		DOM01.DOMSexlab.SetStat(akRef, "Anal",0)
		DOM01.DOMSexlab.SetStat(akRef, "AnalCount",0)
	endif
	if __virgin_status_same == 0
		bool isFemale = ((actorSex%2) == 1)
		DOM01.DOMSexlab.ResetSexuality(akRef,isFemale)
	endif
EndFunction

Function IntegrateSexLabStats()
	if !DOM01.trainSexlabValuesToggle
		return
	endif
	; Consistency check between sex training DOM stats and Sexlab stats
	if vaginal_training == 0.0 ; new actor without JSON file information
		float xv = DOM01.DOMSexlab.GetStat(akRef, "Vaginal")
		if xv > 0.0
			TrainVaginal(xv)
			if __virgin_status_vaginal == 0
				virgin_status_vaginal = 4
			endif
			LogTrace("Had vaginal sex training from Sexlab: amount="+xv+" training="+vaginal_training)
		endif
	endif
	if oral_training == 0.0
		float xv = DOM01.DOMSexlab.GetStat(akRef, "Oral")
		if xv > 0.0
			TrainOral(xv)
			if __virgin_status_oral == 0
				virgin_status_oral = 4
			endif
			LogTrace("Had oral sex training from Sexlab: amount="+xv+" training="+oral_training)
		endif
	endif
	if anal_training == 0.0
		float xv = DOM01.DOMSexlab.GetStat(akRef, "Anal")
		if xv > 0.0
			TrainAnal(xv)
			if __virgin_status_anal == 0
				virgin_status_anal = 4
			endif
			LogTrace("Had anal sex training from Sexlab: amount="+xv+" training="+anal_training)
		endif
	endif
EndFunction

int __number_of_pain = 0
int Property number_of_pain Hidden
	int Function get()
		;LogTrace("number_of_pain.Get() : "+name+" = "+__number_of_pain)	
		return __number_of_pain
	EndFunction
	Function set(int value)
		;LogTrace("number_of_pain.Set() : "+name)	
		if __number_of_pain == value
			return
		endif
		__number_of_pain = value
		if __number_of_pain < 0
			__number_of_pain = 0
		endif
		if __number_of_pain < 127
			akRef.SetFactionRank(DOM01.DOMNbPain, __number_of_pain)
		else
			akRef.SetFactionRank(DOM01.DOMNbPain, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceCrushed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceDepressed()
	EndFunction
EndProperty

int __number_of_bondage = 0
int Property number_of_bondage Hidden
	int Function get()
		;LogTrace("number_of_bondage.Get() : "+name+" = "+__number_of_bondage)	
		return __number_of_bondage
	EndFunction
	Function set(int value)
		;LogTrace("number_of_bondage.Set() : "+name)	
		if __number_of_bondage == value
			return
		endif
		__number_of_bondage = value
		if __number_of_bondage < 0
			__number_of_bondage = 0
		endif
		if __number_of_bondage < 127
			akRef.SetFactionRank(DOM01.DOMNbbondage, __number_of_bondage)
		else
			akRef.SetFactionRank(DOM01.DOMNbBondage, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty

int __number_of_shame = 0
int Property number_of_shame Hidden
	int Function get()
		;LogTrace("number_of_shame.Get() : "+name+" = "+__number_of_shame)	
		return __number_of_shame
	EndFunction
	Function set(int value)
		;LogTrace("number_of_shame.Set() : "+name)	
		if __number_of_shame == value
			return
		endif
		__number_of_shame = value
		if __number_of_shame < 0
			__number_of_shame = 0
		endif
		if __number_of_shame < 127
			akRef.SetFactionRank(DOM01.DOMNbShame, __number_of_shame)
		else
			akRef.SetFactionRank(DOM01.DOMNbShame, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty

int __number_of_rape = 0
int Property number_of_rape Hidden
	int Function get()
		;LogTrace("number_of_rape.Get() : "+name+" = "+__number_of_rape)	
		return __number_of_rape
	EndFunction
	Function set(int value)
		;LogTrace("number_of_rape.Set() : "+name)	
		if __number_of_rape == value
			return
		endif
		__number_of_rape = value
		if __number_of_rape < 0
			__number_of_rape = 0
		endif
		if __number_of_rape < 127
			akRef.SetFactionRank(DOM01.DOMNbRape, __number_of_rape)
		else
			akRef.SetFactionRank(DOM01.DOMNbRape, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceCrushed()
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty

int __number_of_drug = 0
int Property number_of_drug Hidden
	int Function get()
		;LogTrace("number_of_drug.Get() : "+name+" = "+__number_of_drug)	
		return __number_of_drug
	EndFunction
	Function set(int value)
		;LogTrace("number_of_drug.Set() : "+name)	
		if __number_of_drug == value
			return
		endif
		__number_of_drug = value
		if __number_of_drug < 0
			__number_of_drug = 0
		endif
		if __number_of_drug < 127
			akRef.SetFactionRank(DOM01.DOMNbDrug, __number_of_drug)
		else
			akRef.SetFactionRank(DOM01.DOMNbDrug, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceDepressed()
	EndFunction
EndProperty

int __number_of_sex = 0
int Property number_of_sex Hidden
	int Function get()
		;LogTrace("number_of_sex.Get() : "+name+" = "+__number_of_sex)	
		return __number_of_sex
	EndFunction
	Function set(int value)
		;LogTrace("number_of_sex.Set() : "+name)	
		if __number_of_sex == value
			return
		endif
		__number_of_sex = value
		if __number_of_sex < 0
			__number_of_sex = 0
		endif
		if __number_of_sex < 127
			akRef.SetFactionRank(DOM01.DOMNbSex, __number_of_sex)
		else
			akRef.SetFactionRank(DOM01.DOMNbSex, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty

int __number_of_sexformoney = 0
int Property number_of_sexformoney Hidden
	int Function get()
		;LogTrace("number_of_sexformoney.Get() : "+name+" = "+__number_of_sexformoney)	
		return __number_of_sexformoney
	EndFunction
	Function set(int value)
		;LogTrace("number_of_sexformoney.Set() : "+name)	
		if __number_of_sexformoney == value
			return
		endif
		__number_of_sexformoney = value
		if __number_of_sexformoney < 0
			__number_of_sexformoney = 0
		endif
		if __number_of_sexformoney < 127
			akRef.SetFactionRank(DOM01.DOMNbSexForMoney, __number_of_sexformoney)
		else
			akRef.SetFactionRank(DOM01.DOMNbSexForMoney, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceInsecure()
	EndFunction
EndProperty

int __number_of_sexwithothers = 0
int Property number_of_sexwithothers Hidden
	int Function get()
		;LogTrace("number_of_sexwithothers.Get() : "+name+" = "+__number_of_sexwithothers)	
		return __number_of_sexwithothers
	EndFunction
	Function set(int value)
		;LogTrace("number_of_sexwithothers.Set() : "+name)	
		if __number_of_sexwithothers == value
			return
		endif
		__number_of_sexwithothers = value
		if __number_of_sexwithothers < 0
			__number_of_sexwithothers = 0
		endif
		if __number_of_sexwithothers < 127
			akRef.SetFactionRank(DOM01.DOMNbSexWithOthers, __number_of_sexwithothers)
		else
			akRef.SetFactionRank(DOM01.DOMNbSexWithOthers, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceJealous()
	EndFunction
EndProperty

int __number_of_kinktrigger = 0
int Property number_of_kinktrigger Hidden
	int Function get()
		;LogTrace("number_of_kinktrigger.Get() : "+name+" = "+__number_of_kinktrigger)	
		return __number_of_kinktrigger
	EndFunction
	Function set(int value)
		;LogTrace("number_of_kinktrigger.Set() : "+name)	
		if __number_of_kinktrigger == value
			return
		endif
		__number_of_kinktrigger = value
		if __number_of_kinktrigger < 0
			__number_of_kinktrigger = 0
		endif
		if __number_of_kinktrigger < 127
			akRef.SetFactionRank(DOM01.DOMNbKinkTrigger, __number_of_kinktrigger)
		else
			akRef.SetFactionRank(DOM01.DOMNbKinkTrigger, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty

int __number_of_orgasm = 0
int Property number_of_orgasm Hidden
	int Function get()
		;LogTrace("number_of_orgasm.Get() : "+name+" = "+__number_of_orgasm)	
		return __number_of_orgasm
	EndFunction
	Function set(int value)
		;LogTrace("number_of_orgasm.Set() : "+name)	
		if __number_of_orgasm == value
			return
		endif
		__number_of_orgasm = value
		if __number_of_orgasm < 0
			__number_of_orgasm = 0
		endif
		if __number_of_orgasm < 127
			akRef.SetFactionRank(DOM01.DOMNbOrgasm, __number_of_orgasm)
		else
			akRef.SetFactionRank(DOM01.DOMNbOrgasm, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty

int __number_of_toldoff = 0
int Property number_of_toldoff Hidden
	int Function get()
		;LogTrace("number_of_toldoff.Get() : "+name+" = "+__number_of_toldoff)	
		return __number_of_toldoff
	EndFunction
	Function set(int value)
		;LogTrace("number_of_toldoff.Set() : "+name)	
		if __number_of_toldoff == value
			return
		endif
		__number_of_toldoff = value
		if __number_of_toldoff < 0
			__number_of_toldoff = 0
		endif
		if __number_of_toldoff < 127
			akRef.SetFactionRank(DOM01.DOMNbToldoff, __number_of_toldoff)
		else
			akRef.SetFactionRank(DOM01.DOMNbToldoff, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceCrushed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceJealous()
	EndFunction
EndProperty

int __number_of_praise = 0
int Property number_of_praise Hidden
	int Function get()
		;LogTrace("number_of_praise.Get() : "+name+" = "+__number_of_praise)	
		return __number_of_praise
	EndFunction
	Function set(int value)
		;LogTrace("number_of_praise.Set() : "+name)	
		if __number_of_praise == value
			return
		endif
		__number_of_praise = value
		if __number_of_praise < 0
			__number_of_praise = 0
		endif
		if __number_of_praise < 127
			akRef.SetFactionRank(DOM01.DOMNbPraise, __number_of_praise)
		else
			akRef.SetFactionRank(DOM01.DOMNbPraise, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceHappy()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty

int __number_of_comfort = 0
int Property number_of_comfort Hidden
	int Function get()
		;LogTrace("number_of_comfort.Get() : "+name+" = "+__number_of_comfort)	
		return __number_of_comfort
	EndFunction
	Function set(int value)
		;LogTrace("number_of_comfort.Set() : "+name)	
		if __number_of_comfort == value
			return
		endif
		__number_of_comfort = value
		if __number_of_comfort < 0
			__number_of_comfort = 0
		endif
		if __number_of_comfort < 127
			akRef.SetFactionRank(DOM01.DOMNbComfort, __number_of_comfort)
		else
			akRef.SetFactionRank(DOM01.DOMNbComfort, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceDepressed()
		RegisterForUpdateChanceInsecure()
	EndFunction
EndProperty

int __number_of_insult = 0
int Property number_of_insult Hidden
	int Function get()
		;LogTrace("number_of_insult.Get() : "+name+" = "+__number_of_insult)	
		return __number_of_insult
	EndFunction
	Function set(int value)
		;LogTrace("number_of_insult.Set() : "+name)	
		if __number_of_insult == value
			return
		endif
		__number_of_insult = value
		if __number_of_insult < 0
			__number_of_insult = 0
		endif
		if __number_of_insult < 127
			akRef.SetFactionRank(DOM01.DOMNbInsult, __number_of_insult)
		else
			akRef.SetFactionRank(DOM01.DOMNbInsult, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceCrushed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceJealous()
		RegisterForUpdateChanceDepressed()
	EndFunction
EndProperty

int __number_of_flatter = 0
int Property number_of_flatter Hidden
	int Function get()
		;LogTrace("number_of_flatter.Get() : "+name+" = "+__number_of_flatter)	
		return __number_of_flatter
	EndFunction
	Function set(int value)
		;LogTrace("number_of_flatter.Set() : "+name)	
		if __number_of_flatter == value
			return
		endif
		__number_of_flatter = value
		if __number_of_flatter < 0
			__number_of_flatter = 0
		endif
		if __number_of_flatter < 127
			akRef.SetFactionRank(DOM01.DOMNbFlatter, __number_of_flatter)
		else
			akRef.SetFactionRank(DOM01.DOMNbFlatter, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceHappy()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInLove()
		SetLoveInterest()
	EndFunction
EndProperty

int __number_of_threat = 0
int Property number_of_threat Hidden
	int Function get()
		;LogTrace("number_of_threat.Get() : "+name+" = "+__number_of_threat)	
		return __number_of_threat
	EndFunction
	Function set(int value)
		;LogTrace("number_of_threat.Set() : "+name)	
		if __number_of_threat == value
			return
		endif
		__number_of_threat = value
		if __number_of_threat < 0
			__number_of_threat = 0
		endif
		if __number_of_threat < 127
			akRef.SetFactionRank(DOM01.DOMNbThreat, __number_of_threat)
		else
			akRef.SetFactionRank(DOM01.DOMNbThreat, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceJealous()
	EndFunction
EndProperty

int __number_of_promise = 0
int Property number_of_promise Hidden
	int Function get()
		;LogTrace("number_of_promise.Get() : "+name+" = "+__number_of_promise)	
		return __number_of_promise
	EndFunction
	Function set(int value)
		;LogTrace("number_of_promise.Set() : "+name)	
		if __number_of_promise == value
			return
		endif
		__number_of_promise = value
		if __number_of_promise < 0
			__number_of_promise = 0
		endif
		if __number_of_promise < 127
			akRef.SetFactionRank(DOM01.DOMNbPromise, __number_of_promise)
		else
			akRef.SetFactionRank(DOM01.DOMNbPromise, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceDepressed()
	EndFunction
EndProperty

int __number_of_chat_feelings = 0
int Property number_of_chat_feelings Hidden
	int Function get()
		;LogTrace("number_of_chat_feelings.Get() : "+name+" = "+__number_of_chat_feelings)	
		return __number_of_chat_feelings
	EndFunction
	Function set(int value)
		;LogTrace("number_of_chat_feelings.Set() : "+name)	
		if __number_of_chat_feelings == value
			return
		endif
		__number_of_chat_feelings = value
		if __number_of_chat_feelings < 0
			__number_of_chat_feelings = 0
		endif
		if __number_of_chat_feelings < 127
			akRef.SetFactionRank(DOM01.DOMNbChatFeelings, __number_of_chat_feelings)
		else
			akRef.SetFactionRank(DOM01.DOMNbChatFeelings, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceAshamed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceHappy()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceDepressed()
		RegisterForUpdateChanceInsecure()
	EndFunction
EndProperty

int __number_of_chat_personality = 0
int Property number_of_chat_personality Hidden
	int Function get()
		;LogTrace("number_of_chat_personality.Get() : "+name+" = "+__number_of_chat_personality)	
		return __number_of_chat_personality
	EndFunction
	Function set(int value)
		;LogTrace("number_of_chat_personality.Set() : "+name)	
		if __number_of_chat_personality == value
			return
		endif
		__number_of_chat_personality = value
		if __number_of_chat_personality < 0
			__number_of_chat_personality = 0
		endif
		if __number_of_chat_personality < 127
			akRef.SetFactionRank(DOM01.DOMNbChatPersonality, __number_of_chat_personality)
		else
			akRef.SetFactionRank(DOM01.DOMNbChatPersonality, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceProud()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceHappy()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
		RegisterForUpdateChanceJealous()
		RegisterForUpdateChanceInsecure()
	EndFunction
EndProperty

int __number_of_shock = 0
int Property number_of_shock Hidden
	int Function get()
		;LogTrace("number_of_shock.Get() : "+name+" = "+__number_of_shock)	
		return __number_of_shock
	EndFunction
	Function set(int value)
		;LogTrace("number_of_shock.Set() : "+name)	
		if __number_of_shock == value
			return
		endif
		__number_of_shock = value
		if __number_of_shock < 0
			__number_of_shock = 0
		endif
		if __number_of_shock < 127
			akRef.SetFactionRank(DOM01.DOMNbShock, __number_of_shock)
		else
			akRef.SetFactionRank(DOM01.DOMNbShock, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceSad()
		RegisterForUpdateChanceCrushed()
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceInLove()
	EndFunction
EndProperty

int __number_of_broken = 0
int Property number_of_broken Hidden
	int Function get()
		;LogTrace("number_of_broken.Get() : "+name+" = "+__number_of_broken)	
		return __number_of_broken
	EndFunction
	Function set(int value)
		;LogTrace("number_of_broken.Set() : "+name)	
		if __number_of_broken == value
			return
		endif
		__number_of_broken = value
		if __number_of_broken < 0
			__number_of_broken = 0
		endif
		if __number_of_broken < 127
			akRef.SetFactionRank(DOM01.DOMNbBroken, __number_of_broken)
		else
			akRef.SetFactionRank(DOM01.DOMNbBroken, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInLove()
	EndFunction
EndProperty

int __number_of_brainwashed = 0
int Property number_of_brainwashed Hidden
	int Function get()
		;LogTrace("number_of_brainwashed.Get() : "+name+" = "+__number_of_brainwashed)	
		return __number_of_brainwashed
	EndFunction
	Function set(int value)
		;LogTrace("number_of_brainwashed.Set() : "+name)	
		if __number_of_brainwashed == value
			return
		endif
		__number_of_brainwashed = value
		if __number_of_brainwashed < 0
			__number_of_brainwashed = 0
		endif
		if __number_of_brainwashed < 127
			akRef.SetFactionRank(DOM01.DOMNbBrainWashed, __number_of_brainwashed)
		else
			akRef.SetFactionRank(DOM01.DOMNbBrainWashed, 127)
		endif
		if __number_of_brainwashed == 1 && !is_initializing
			DOM01.TrainSkillDeceiver(actor_alias.GetCurrentTrainer(),1.0)
		endif
		; Update dependencies
		RegisterForUpdateChanceShock()
		RegisterForUpdateChanceBroken()
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInLove()
	EndFunction
EndProperty

float __timer_for_broken = 0.0 ; in days
float Property timer_for_broken Hidden
	float Function get()
		LogTrace("timer_for_broken.Get() "+__timer_for_broken)	
		return __timer_for_broken
	EndFunction
	Function set(float value)
		if __timer_for_broken == value
			return
		endif
		__timer_for_broken = value
		;LogTrace("timer_for_broken.Set() "+__timer_for_broken)	
		if __timer_for_broken < 127
			akRef.SetFactionRank(DOM01.DOMTraumaInDays, __timer_for_broken as int)
		else
			akRef.SetFactionRank(DOM01.DOMTraumaInDays, 127)
		endif

		; Update dependencies
		RegisterForUpdateChanceCharmed()
		RegisterForUpdateChanceLoyal()
		RegisterForUpdateChanceInlove()
	EndFunction
EndProperty

int __number_of_trainee = 0
int Property number_of_trainee Hidden
	int Function get()
		;LogTrace("number_of_trainee.Get() : "+name+" = "+__number_of_trainee)	
		return __number_of_trainee
	EndFunction
	Function set(int value)
		;LogTrace("number_of_trainee.Set() : "+name)	
		if __number_of_trainee == value
			return
		endif
		__number_of_trainee = value
		if __number_of_trainee < 0
			__number_of_trainee = 0
		endif
		if __number_of_trainee < 127
			akRef.SetFactionRank(DOM01.DOMNbTrainee, __number_of_trainee)
		else
			akRef.SetFactionRank(DOM01.DOMNbTrainee, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceHappy()
	EndFunction
EndProperty

int __number_of_trainer = 0
int Property number_of_trainer Hidden
	int Function get()
		;LogTrace("number_of_trainer.Get() : "+name+" = "+__number_of_trainer)	
		return __number_of_trainer
	EndFunction
	Function set(int value)
		;LogTrace("number_of_trainer.Set() : "+name)	
		if __number_of_trainer == value
			return
		endif
		__number_of_trainer = value
		if __number_of_trainer < 0
			__number_of_trainer = 0
		endif
		if __number_of_trainer < 127
			akRef.SetFactionRank(DOM01.DOMNbTrainer, __number_of_trainer)
		else
			akRef.SetFactionRank(DOM01.DOMNbTrainer, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceHappy()
	EndFunction
EndProperty

int __number_of_recruitedslavers = 0
int Property number_of_recruitedslavers  Hidden
	int Function get()
		;LogTrace("number_of_recruitedslavers .Get() : "+name+" = "+__number_of_recruitedslavers )	
		return __number_of_recruitedslavers 
	EndFunction
	Function set(int value)
		;LogTrace("number_of_recruitedslavers .Set() : "+name)	
		if __number_of_recruitedslavers  == value
			return
		endif
		__number_of_recruitedslavers  = value
		if __number_of_recruitedslavers  < 0
			__number_of_recruitedslavers  = 0
		endif
		if __number_of_recruitedslavers  < 127
			akRef.SetFactionRank(DOM01.DOMNbRecruitedSlavers, __number_of_recruitedslavers )
		else
			akRef.SetFactionRank(DOM01.DOMNbRecruitedSlavers, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceHappy()
	EndFunction
EndProperty

int __number_of_whoredslaves = 0
int Property number_of_whoredslaves  Hidden
	int Function get()
		;LogTrace("number_of_whoredslaves .Get() : "+name+" = "+__number_of_whoredslaves )	
		return __number_of_whoredslaves 
	EndFunction
	Function set(int value)
		;LogTrace("number_of_whoredslaves .Set() : "+name)	
		if __number_of_whoredslaves  == value
			return
		endif
		__number_of_whoredslaves  = value
		if __number_of_whoredslaves  < 0
			__number_of_whoredslaves  = 0
		endif
		if __number_of_whoredslaves  < 127
			akRef.SetFactionRank(DOM01.DOMNbWhoredSlaves, __number_of_whoredslaves )
		else
			akRef.SetFactionRank(DOM01.DOMNbWhoredSlaves, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceHappy()
	EndFunction
EndProperty

int __number_of_ransomedslaves = 0
int Property number_of_ransomedslaves  Hidden
	int Function get()
		;LogTrace("number_of_ransomedslaves .Get() : "+name+" = "+__number_of_ransomedslaves )	
		return __number_of_ransomedslaves 
	EndFunction
	Function set(int value)
		;LogTrace("number_of_ransomedslaves .Set() : "+name)	
		if __number_of_ransomedslaves  == value
			return
		endif
		__number_of_ransomedslaves  = value
		if __number_of_ransomedslaves  < 0
			__number_of_ransomedslaves  = 0
		endif
		if __number_of_ransomedslaves  < 127
			akRef.SetFactionRank(DOM01.DOMNbRansomedSlaves, __number_of_ransomedslaves )
		else
			akRef.SetFactionRank(DOM01.DOMNbRansomedSlaves, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceHappy()
	EndFunction
EndProperty

int __number_of_capturedslaves = 0
int Property number_of_capturedslaves  Hidden
	int Function get()
		;LogTrace("number_of_capturedslaves .Get() : "+name+" = "+__number_of_capturedslaves )	
		return __number_of_capturedslaves 
	EndFunction
	Function set(int value)
		;LogTrace("number_of_capturedslaves .Set() : "+name)	
		if __number_of_capturedslaves  == value
			return
		endif
		__number_of_capturedslaves  = value
		if __number_of_capturedslaves  < 0
			__number_of_capturedslaves  = 0
		endif
		if __number_of_capturedslaves  < 127
			akRef.SetFactionRank(DOM01.DOMNbCapturedSlaves, __number_of_capturedslaves )
		else
			akRef.SetFactionRank(DOM01.DOMNbCapturedSlaves, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceHappy()
	EndFunction
EndProperty

int __number_of_brokenslaves = 0
int Property number_of_brokenslaves  Hidden
	int Function get()
		;LogTrace("number_of_brokenslaves .Get() : "+name+" = "+__number_of_brokenslaves )	
		return __number_of_brokenslaves 
	EndFunction
	Function set(int value)
		;LogTrace("number_of_brokenslaves .Set() : "+name)	
		if __number_of_brokenslaves  == value
			return
		endif
		__number_of_brokenslaves  = value
		if __number_of_brokenslaves  < 0
			__number_of_brokenslaves  = 0
		endif
		if __number_of_brokenslaves  < 127
			akRef.SetFactionRank(DOM01.DOMNbBrokenSlaves, __number_of_brokenslaves )
		else
			akRef.SetFactionRank(DOM01.DOMNbBrokenSlaves, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceHappy()
	EndFunction
EndProperty

int __number_of_soldslaves = 0
int Property number_of_soldslaves  Hidden
	int Function get()
		;LogTrace("number_of_soldslaves .Get() : "+name+" = "+__number_of_soldslaves )	
		return __number_of_soldslaves 
	EndFunction
	Function set(int value)
		;LogTrace("number_of_soldslaves .Set() : "+name)	
		if __number_of_soldslaves  == value
			return
		endif
		__number_of_soldslaves  = value
		if __number_of_soldslaves  < 0
			__number_of_soldslaves  = 0
		endif
		if __number_of_soldslaves  < 127
			akRef.SetFactionRank(DOM01.DOMNbSoldSlaves, __number_of_soldslaves )
		else
			akRef.SetFactionRank(DOM01.DOMNbSoldSlaves, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceHappy()
	EndFunction
EndProperty

int __number_of_player_fling = 0
int Property number_of_player_fling Hidden
	int Function get()
		;LogTrace("number_of_player_fling.Get() : "+name+" = "+__number_of_player_fling)	
		return __number_of_player_fling
	EndFunction
	Function set(int value)
		;LogTrace("number_of_player_fling.Set() : "+name)	
		if __number_of_player_fling == value
			return
		endif
		__number_of_player_fling = value
		if __number_of_player_fling < 0
			__number_of_player_fling = 0
		endif
		if __number_of_player_fling < 127
			akRef.SetFactionRank(DOM01.DOMNbPlayerFling, __number_of_player_fling)
		else
			akRef.SetFactionRank(DOM01.DOMNbPlayerFling, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceJealous()
		RegisterForUpdateChanceDepressed()
		RegisterForUpdateChanceInsecure()
	EndFunction
EndProperty

int __number_of_player_chat = 0
int Property number_of_player_chat Hidden
	int Function get()
		;LogTrace("number_of_player_chat.Get() : "+name+" = "+__number_of_player_chat)	
		return __number_of_player_chat
	EndFunction
	Function set(int value)
		;LogTrace("number_of_player_chat.Set() : "+name)	
		if __number_of_player_chat == value
			return
		endif
		__number_of_player_chat = value
		if __number_of_player_chat < 0
			__number_of_player_chat = 0
		endif
		if __number_of_player_chat < 127
			akRef.SetFactionRank(DOM01.DOMNbPlayerChat, __number_of_player_chat)
		else
			akRef.SetFactionRank(DOM01.DOMNbPlayerChat, 127)
		endif
		; Update dependencies
		RegisterForUpdateChanceJealous()
		RegisterForUpdateChanceDepressed()
		RegisterForUpdateChanceInsecure()
	EndFunction
EndProperty

; ### Response to different order types

Function HandleMindTimers()
	if timer_obedient > 0
		timer_obedient -= 1
	endif
	if timer_warned > 0
		timer_warned -= 1
		if timer_warned == 0
			reason_warned = -1
		endif
	endif
EndFunction

int Property timer_obedient = 0 Auto Hidden
bool Function WillObeySubmitted(int reason) ; submission based
	if IsObedient()
		if IsDevoted()
			SendNotificationOrderMaster(name+" worshipfully listens to ","")
			return true
		endif
		if IsScaredToObey()
			SendNotificationOrder(title+name+" is too afraid to say no")	
			SetObedientTimer(10)
			return true
		endif
		if is_slave
			SendNotificationOrder(name+" obeys like a good slave")
		else
			SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and obeys")
		endif
		SetObedientTimer(10)
		return true
	endif

	float x = submission
	if RandomFloat()*100.0 < x
		if is_slave
			SendNotificationOrder(name+" obeys like a well trained slave")
		else
			SendNotificationOrder(name+" obeys like a perfect slaver")
		endif
		SetObedientTimer(10)
		return true
	endif

	if RandomFloat()*10.0 < MOD_Authority + MOD_Humility
		if ((actorSex%2) == 1)
			SendNotificationOrder(name+" obeys like a good girl")
		else
			SendNotificationOrder(name+" obeys like a good boy")
		endif
		SetObedientTimer(10)
		return true
	endif

	if WillObeyBecausePunished(reason,0.5)
		SendNotificationOrder(name+" remembers the punishment and obeys")
		SetObedientTimer(10)
		return true
	endif
	
	int was_warned = WillObeyBecauseWarned(reason,0.5)
	if was_warned < 0
		SetNextPunishmentReasonForceMessage(reason,"won't submit to you")
		return false
	endif
		
	if was_warned == 0
		SetNextPunishmentReasonForceMessage(reason,"won't submit to you in spite of your warning")
		return false
	endif
	
	SendNotificationOrder(name+" remembers your warning and gets in position")	
	SetObedientTimer(10)
	return true
EndFunction

bool Function WillObeyHumiliated(int reason) ; humiliation based
	if IsObedient()
		if IsDevoted()
			SendNotificationOrderMaster(name+" worshipfully listens to ","")
			return true
		endif
		if IsScaredToObey()
			SendNotificationOrder(title+name+" is too afraid to say no")	
			SetObedientTimer(10)
			return true
		endif
		if is_slave
			SendNotificationOrder(name+" obeys like a good slave")
		else
			SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and obeys")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	float x = humiliation
	if RandomFloat()*100.0 < x
		if is_slave
			SendNotificationOrder(name+" obeys like a well trained slave")
		else
			SendNotificationOrder(name+" obeys like a perfect slaver")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	if RandomFloat()*10.0 < MOD_Authority + MOD_Naivety
		if ((actorSex%2) == 1)
			SendNotificationOrder(name+" obeys like a good girl")
		else
			SendNotificationOrder(name+" obeys like a good boy")
		endif
		SetObedientTimer(10)
		return true
	endif

	if WillObeyBecausePunished(reason,0.5)
		SendNotificationOrder(name+" remembers the punishment and obeys")
		SetObedientTimer(10)
		return true
	endif

	int was_warned = WillObeyBecauseWarned(reason,0.5)
	if was_warned < 0
		SetNextPunishmentReasonForceMessage(reason,"won't let you humiliate "+actorObjective)
		return false
	endif
	
	if was_warned == 0
		SetNextPunishmentReasonForceMessage(reason,"won't let you humiliate "+actorObjective+" in spite of your warning")
		return false
	endif
	
	SendNotificationOrder(name+" remembers your warning and gets in position")	
	SetObedientTimer(10)
	return true
EndFunction

bool Function WillObeyResignated(int reason) ; resignation based
	if IsObedient()
		if IsDevoted()
			SendNotificationOrderMaster(name+" worshipfully listens to ","")
			return true
		endif
		if IsScaredToObey()
			SendNotificationOrder(title+name+" is too afraid to say no")	
			SetObedientTimer(10)
			return true
		endif
		if is_slave
			SendNotificationOrder(name+" obeys like a good slave")
		else
			SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and obeys")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	float x = resignation
	if RandomFloat()*100.0 < x
		if is_slave
			SendNotificationOrder(name+" obeys like a well trained slave")
		else
			SendNotificationOrder(name+" obeys like a perfect slaver")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	if RandomFloat()*10.0 < MOD_Authority + MOD_Prudent
		if ((actorSex%2) == 1)
			SendNotificationOrder(name+" obeys like a good girl")
		else
			SendNotificationOrder(name+" obeys like a good boy")
		endif
		SetObedientTimer(10)
		return true
	endif

	if WillObeyBecausePunished(reason,0.5)
		SendNotificationOrder(name+" remembers the punishment and obeys")
		SetObedientTimer(10)
		return true
	endif

	int was_warned = WillObeyBecauseWarned(reason,0.5)
	if was_warned < 0
		SetNextPunishmentReasonForceMessage(reason,"doesn't want to follow your orders")
		return false
	endif
	
	if was_warned == 0
		SetNextPunishmentReasonForceMessage(reason,"won't follow your orders in spite of your warning")
		return false
	endif
	
	SendNotificationOrder(name+" remembers your warning and agrees")	
	SetObedientTimer(10)
	return true
EndFunction

bool Function WillObeydominated(int reason) ; submission+pose_training based
	if IsObedient()
		if IsDevoted()
			SendNotificationOrderMaster(name+" worshipfully listens to ","")
			return true
		endif
		if IsScaredToObey()
			SendNotificationOrder(title+name+" is too afraid to say no")	
			SetObedientTimer(10)
			return true
		endif
		if is_slave
			SendNotificationOrder(name+" obeys like a good slave")
		else
			SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and obeys")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	float x = submission+pose_training
	if RandomFloat()*200.0 < x
		if is_slave
			SendNotificationOrder(name+" obeys like a well trained slave")
		else
			SendNotificationOrder(name+" obeys like a perfect slaver")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	if RandomFloat()*10.0 < MOD_Authority + MOD_Sincerity
		if ((actorSex%2) == 1)
			SendNotificationOrder(name+" obeys like a good girl")
		else
			SendNotificationOrder(name+" obeys like a good boy")
		endif
		SetObedientTimer(10)
		return true
	endif

	if WillObeyBecausePunished(reason,0.5)
		SendNotificationOrder(name+" remembers the punishment and obeys")
		SetObedientTimer(10)
		return true
	endif

	int was_warned = WillObeyBecauseWarned(reason,0.5)
	if was_warned < 0
		SetNextPunishmentReasonForceMessage(reason,"won't let you dominate "+actorObjective)
		return false
	endif
	
	if was_warned == 0
		SetNextPunishmentReasonForceMessage(reason,"won't let you dominate "+actorObjective+" in spite of your warning")
		return false
	endif
	
	SendNotificationOrder(name+" remembers your warning and gets in position")	
	SetObedientTimer(10)
	return true
EndFunction

bool Function WillObeyObjectified(int reason) ; humiliation+pose_training based
	if IsObedient()
		if IsDevoted()
			SendNotificationOrderMaster(name+" worshipfully listens to ","")
			return true
		endif
		if IsScaredToObey()
			SendNotificationOrder(title+name+" is too afraid to say no")	
			SetObedientTimer(10)
			return true
		endif
		if is_slave
			SendNotificationOrder(name+" obeys like a good slave")
		else
			SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and obeys")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	float x = humiliation+pose_training
	if RandomFloat()*200.0 < x
		if is_slave
			SendNotificationOrder(name+" obeys like a well trained slave")
		else
			SendNotificationOrder(name+" obeys like a perfect slaver")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	if RandomFloat()*10.0 < MOD_Authority + MOD_Liveliness
		if ((actorSex%2) == 1)
			SendNotificationOrder(name+" obeys like a good girl")
		else
			SendNotificationOrder(name+" obeys like a good boy")
		endif
		SetObedientTimer(10)
		return true
	endif

	if WillObeyBecausePunished(reason,0.5)
		SendNotificationOrder(name+" remembers the punishment and obeys")
		SetObedientTimer(10)
		return true
	endif

	int was_warned = WillObeyBecauseWarned(reason,0.5)
	if was_warned < 0
		SetNextPunishmentReasonForceMessage(reason,"won't let you objectify "+actorObjective)
		return false
	endif
	
	if was_warned == 0
		SetNextPunishmentReasonForceMessage(reason,"won't let you objectify "+actorObjective+" in spite of your warning")
		return false
	endif
	
	SendNotificationOrder(name+" remembers your warning and gets in position")	
	SetObedientTimer(10)
	return true
EndFunction

bool Function WillObeyEnslaved(int reason) ; resignation+pose_training based
	if IsObedient()
		if IsDevoted()
			SendNotificationOrderMaster(name+" worshipfully listens to ","")
			return true
		endif
		if IsScaredToObey()
			SendNotificationOrder(title+name+" is too afraid to say no")	
			SetObedientTimer(10)
			return true
		endif
		if is_slave
			SendNotificationOrder(name+" obeys like a good slave")
		else
			SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and obeys")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	float x = resignation+pose_training
	if RandomFloat()*200.0 < x
		if is_slave
			SendNotificationOrder(name+" obeys like a well trained slave")
		else
			SendNotificationOrder(name+" obeys like a perfect slaver")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	if RandomFloat()*10.0 < MOD_Authority + MOD_Prudent
		if ((actorSex%2) == 1)
			SendNotificationOrder(name+" obeys like a good girl")
		else
			SendNotificationOrder(name+" obeys like a good boy")
		endif
		SetObedientTimer(10)
		return true
	endif

	if WillObeyBecausePunished(reason,0.5)
		SendNotificationOrder(name+" remembers the punishment and obeys")
		SetObedientTimer(10)
		return true
	endif

	int was_warned = WillObeyBecauseWarned(reason,0.5)
	if was_warned < 0
		SetNextPunishmentReasonForceMessage(reason,"doesn't want to serve you")
		return false
	endif
	
	if was_warned == 0
		SetNextPunishmentReasonForceMessage(reason,"doesn't want to serve you in spite of your warning")
		return false
	endif
	
	SendNotificationOrder(name+" remembers your warning and gets in position")	
	SetObedientTimer(10)
	return true
EndFunction

bool Function WillObeyDegraded(int reason) ; submission+humiliation based
	if IsObedient()
		if IsDevoted()
			SendNotificationOrderMaster(name+" worshipfully listens to ","")
			return true
		endif
		if IsScaredToObey()
			SendNotificationOrder(title+name+" is too afraid to say no")	
			SetObedientTimer(10)
			return true
		endif
		if is_slave
			SendNotificationOrder(name+" obeys like a good slave")
		else
			SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and obeys")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	float x = submission+humiliation
	if RandomFloat()*200.0 < x
		if is_slave
			SendNotificationOrder(name+" obeys like a well trained slave")
		else
			SendNotificationOrder(name+" obeys like a perfect slaver")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	if RandomFloat()*10.0 < MOD_Authority + MOD_Ingenuity
		if ((actorSex%2) == 1)
			SendNotificationOrder(name+" obeys like a good girl")
		else
			SendNotificationOrder(name+" obeys like a good boy")
		endif
		SetObedientTimer(10)
		return true
	endif

	if WillObeyBecausePunished(reason,0.5)
		SendNotificationOrder(name+" remembers the punishment and obeys")
		SetObedientTimer(10)
		return true
	endif

	int was_warned = WillObeyBecauseWarned(reason,0.5)
	if was_warned < 0
		SetNextPunishmentReasonForceMessage(reason,"won't let you degrade "+actorObjective)
		return false
	endif
	
	if was_warned == 0
		SetNextPunishmentReasonForceMessage(reason,"won't let you degrade "+actorObjective+" in spite of your warning")
		return false
	endif
	
	SendNotificationOrder(name+" remembers your warning and gets in position")	
	SetObedientTimer(10)
	return true
EndFunction

bool Function WillObeyDisgraced(int reason) ; humiliation+resignation based
	if IsObedient()
		if IsDevoted()
			SendNotificationOrderMaster(name+" worshipfully listens to ","")
			return true
		endif
		if IsScaredToObey()
			SendNotificationOrder(title+name+" is too afraid to say no")	
			SetObedientTimer(10)
			return true
		endif
		if is_slave
			SendNotificationOrder(name+" obeys like a good slave")
		else
			SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and obeys")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	float x = humiliation+resignation
	if RandomFloat()*200.0 < x
		if is_slave
			SendNotificationOrder(name+" obeys like a well trained slave")
		else
			SendNotificationOrder(name+" obeys like a perfect slaver")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	if RandomFloat()*10.0 < MOD_Authority + MOD_Naivety
		if ((actorSex%2) == 1)
			SendNotificationOrder(name+" obeys like a good girl")
		else
			SendNotificationOrder(name+" obeys like a good boy")
		endif
		SetObedientTimer(10)
		return true
	endif

	if WillObeyBecausePunished(reason,0.5)
		SendNotificationOrder(name+" remembers the punishment and obeys")
		SetObedientTimer(10)
		return true
	endif

	int was_warned = WillObeyBecauseWarned(reason,0.5)
	if was_warned < 0
		SetNextPunishmentReasonForceMessage(reason,"won't let you disgrace "+actorObjective)
		return false
	endif
	
	if was_warned == 0
		SetNextPunishmentReasonForceMessage(reason,"won't let you disgrace "+actorObjective+" in spite of your warning")
		return false
	endif
	
	SendNotificationOrder(name+" remembers your warning and gets in position")	
	SetObedientTimer(10)
	return true
EndFunction

bool Function WillObeyAbused(int reason) ; resignation+submission based
	if IsObedient()
		if IsDevoted()
			SendNotificationOrderMaster(name+" worshipfully listens to ","")
			return true
		endif
		if IsScaredToObey()
			SendNotificationOrder(title+name+" is too afraid to say no")	
			SetObedientTimer(10)
			return true
		endif
		if is_slave
			SendNotificationOrder(name+" obeys like a good slave")
		else
			SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and obeys")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	float x = submission+resignation
	if RandomFloat()*200.0 < x
		if is_slave
			SendNotificationOrder(name+" obeys like a well trained slave")
		else
			SendNotificationOrder(name+" obeys like a perfect slaver")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	if RandomFloat()*10.0 < MOD_Authority + MOD_Laborious
		if ((actorSex%2) == 1)
			SendNotificationOrder(name+" obeys like a good girl")
		else
			SendNotificationOrder(name+" obeys like a good boy")
		endif
		SetObedientTimer(10)
		return true
	endif

	if WillObeyBecausePunished(reason,0.5)
		SendNotificationOrder(name+" remembers the punishment and obeys")
		SetObedientTimer(10)
		return true
	endif

	int was_warned = WillObeyBecauseWarned(reason,0.5)
	if was_warned < 0
		SetNextPunishmentReasonForceMessage(reason,"won't let you abuse "+actorObjective)
		return false
	endif
	
	if was_warned == 0
		SetNextPunishmentReasonForceMessage(reason,"won't let you abuse "+actorObjective+" in spite of your warning")
		return false
	endif
	
	SendNotificationOrder(name+" remembers your warning and gets in position")	
	SetObedientTimer(10)
	return true
EndFunction

bool Function WillObeySubjugated(int reason) ; submission+respect_training based
	if IsObedient()
		if IsDevoted()
			SendNotificationOrderMaster(name+" worshipfully listens to ","")
			return true
		endif
		if IsScaredToObey()
			SendNotificationOrder(title+name+" is too afraid to say no")	
			SetObedientTimer(10)
			return true
		endif
		if is_slave
			SendNotificationOrder(name+" obeys like a good slave")
		else
			SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and obeys")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	float x = submission+respect_training
	if RandomFloat()*200.0 < x
		if is_slave
			SendNotificationOrder(name+" obeys like a well trained slave")
		else
			SendNotificationOrder(name+" obeys like a perfect slaver")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	if RandomFloat()*10.0 < MOD_Authority + MOD_Discipline
		if ((actorSex%2) == 1)
			SendNotificationOrder(name+" obeys like a good girl")
		else
			SendNotificationOrder(name+" obeys like a good boy")
		endif
		SetObedientTimer(10)
		return true
	endif

	if WillObeyBecausePunished(reason,0.5)
		SendNotificationOrder(name+" remembers the punishment and obeys")
		SetObedientTimer(10)
		return true
	endif

	int was_warned = WillObeyBecauseWarned(reason,0.5)
	if was_warned < 0
		SetNextPunishmentReasonForceMessage(reason,"refuses to be treated like a slave")
		return false
	endif
	
	if was_warned == 0
		SetNextPunishmentReasonForceMessage(reason,"refuses to be treated like a slave in spite of your warning")
		return false
	endif
	
	SendNotificationOrderMaster(name+" respectfully listens to ","")
	SetObedientTimer(10)
	return true
EndFunction

bool Function WillObeyTamed(int reason) ; humiliation+respect_training based
	if IsObedient()
		if IsDevoted()
			SendNotificationOrderMaster(name+" worshipfully listens to ","")
			return true
		endif
		if IsScaredToObey()
			SendNotificationOrder(title+name+" is too afraid to say no")	
			SetObedientTimer(10)
			return true
		endif
		if is_slave
			SendNotificationOrder(name+" obeys like a good slave")
		else
			SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and obeys")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	float x = humiliation+respect_training
	if RandomFloat()*200.0 < x
		if is_slave
			SendNotificationOrder(name+" obeys like a well trained slave")
		else
			SendNotificationOrder(name+" obeys like a perfect slaver")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	if RandomFloat()*10.0 < MOD_Authority + MOD_Ingenuity
		if ((actorSex%2) == 1)
			SendNotificationOrder(name+" obeys like a good girl")
		else
			SendNotificationOrder(name+" obeys like a good boy")
		endif
		SetObedientTimer(10)
		return true
	endif

	if WillObeyBecausePunished(reason,0.5)
		SendNotificationOrder(name+" remembers the punishment and obeys")
		SetObedientTimer(10)
		return true
	endif

	int was_warned = WillObeyBecauseWarned(reason,0.5)
	if was_warned < 0
		SetNextPunishmentReasonForceMessage(reason,"refuses to be treated like a slave")
		return false
	endif
	
	if was_warned == 0
		SetNextPunishmentReasonForceMessage(reason,"refuses to be treated like a slave in spite of your warning")
		return false
	endif
	
	SendNotificationOrderMaster(name+" respectfully listens to ","")
	SetObedientTimer(10)
	return true
EndFunction

bool Function WillObeySubdued(int reason) ; resignation+respect_training based
	if IsObedient()
		if IsDevoted()
			SendNotificationOrderMaster(name+" worshipfully listens to ","")
			return true
		endif
		if IsScaredToObey()
			SendNotificationOrder(title+name+" is too afraid to say no")	
			SetObedientTimer(10)
			return true
		endif
		if is_slave
			SendNotificationOrder(name+" obeys like a good slave")
		else
			SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and obeys")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	float x = resignation+respect_training
	if RandomFloat()*200.0 < x
		if is_slave
			SendNotificationOrder(name+" obeys like a well trained slave")
		else
			SendNotificationOrder(name+" obeys like a perfect slaver")
		endif
		SetObedientTimer(10)
		return true
	endif
	
	if RandomFloat()*10.0 < MOD_Authority + MOD_Organized
		if ((actorSex%2) == 1)
			SendNotificationOrder(name+" obeys like a good girl")
		else
			SendNotificationOrder(name+" obeys like a good boy")
		endif
		SetObedientTimer(10)
		return true
	endif

	if WillObeyBecausePunished(reason,0.5)
		SendNotificationOrder(name+" remembers the punishment and obeys")
		SetObedientTimer(10)
		return true
	endif

	int was_warned = WillObeyBecauseWarned(reason,0.5)
	if was_warned < 0
		SetNextPunishmentReasonForceMessage(reason,"refuses to be treated like a slave")
		return false
	endif
	
	if was_warned == 0
		SetNextPunishmentReasonForceMessage(reason,"refuses to be treated like a slave in spite of your warning")
		return false
	endif
	
	SendNotificationOrderMaster(name+" respectfully listens to ","")
	SetObedientTimer(10)
	return true
EndFunction

; ### Response to orders and interactions

; Submitted   = submission  + orgasm                 ; Masturbate laying
; Humiliated  = humiliation + orgasm                 ; Masturbate standing
; Resignated  = resignation + orgasm                 
; Shamed      = submission  + humiliation + orgasm   ; Masturbate kneeling
; Degraded    = submission  + humiliation            ; Masturbate
; Abused      = submission  + humiliation + anger    ; Kiss forced
; Objectified = humiliation + resignation + anger    ; Kiss long
; Tamed       = resignation + submission  + anger    ; Kiss short
; Forced      = submission  + fear                   ; Grab back
; dominated   = submission  + anger                  ; Grab floor
; Subjugated  = submission  + respect                ; Grab front
; Terrorized  = resignation + fear
; Enslaved    = resignation + anger
; Subdued     = resignation + respect
; Debased     = humiliation + fear
; Demeaned    = humiliation + anger
; Disgraced   = humiliation + respect

string Function GetTrainingStatusName()
	if !is_Slave
		return "slaver"
	endif
	if training_status_name != "" && training_status_name != "freshly captured"
		return training_status_name
	endif
	return DOM01.DOM04.GetTrainingStatusName(training_status)
EndFunction

int property training_status = 0 Auto Hidden
string property training_status_name = "freshly captured" Auto Hidden
Function UpdateTrainingStatus()
	;LogTrace("UpdateTrainingStatus old training_status="+training_status)
	int status = GetTrainingStatusIndex()
	if status == training_status
		return
	endif
	training_status = status
	training_status_name = DOM01.DOM04.GetTrainingStatusName(training_status)
	SendNotificationAction(name+" "+actorBeVerb+" "+training_status_name)
	if actor_alias != None
		actor_alias.SetTatsGlowColor()
		if is_player_slave
			actor_alias.SendExternalEventSSI("TrainingStatusUpdate",training_status_name,training_status)
			DOM01.DOM04.NotifyTrainingStatusUpdate(actor_alias,training_status)
		endif
	endif
	LogTrace("UpdateTrainingStatus new training_status="+training_status)
EndFunction

int Function GetTrainingStatusIndex()
	float xtot = __total_training
	if xtot >= 100.0 || IsDevoted()
		float xtot2 = __total_love_feelings+__total_loyal_feelings
		if IsInLove() && xtot < 100.0
			return 22 ; bewitched
		endif
		if xtot2 >= 200.0
			return 27
		endif
		if xtot2 < 20.0
			return 20
		endif
		float ymax = love_admiration
		if love_desire > ymax	
			ymax = love_desire
		endif
		if love_fascination > ymax	
			ymax = love_fascination
		endif
		if loyal_absolution > ymax	
			ymax = loyal_absolution
		endif
		if loyal_devotion > ymax	
			ymax = loyal_devotion
		endif
		if loyal_worship > ymax	
			ymax = loyal_worship
		endif
		
		if love_desire >= ymax
			return 21
		endif
		if love_fascination >= ymax
			return 22
		endif
		if love_admiration >= ymax
			return 23
		endif
		if loyal_worship >= ymax
			return 24
		endif
		if loyal_absolution >= ymax
			return 25
		endif
		if loyal_devotion >= ymax
			return 26
		endif
		return 20 ; mesmerized
	endif
	if xtot < 10.0
		if GetMoodIndex() == 9 ; Broken
			return 7 ; dominated
		endif
		return 0
	endif
	float xDegraded    = GetDegradedEffect()
	float xAbused      = GetAbusedEffect()
	float xObjectified = GetObjectifiedEffect()
	float xTamed       = GetTamedEffect()

	float xForced      = GetForcedEffect()
	float xdominated   = GetDominatedEffect()
	float xSubjugated  = GetSubjugatedEffect()
	
	float xTerrorized  = GetTerrorizedEffect()
	float xEnslaved    = GetEnslavedEffect()
	float xSubdued     = GetSubduedEffect()

	float xDebased     = GetDebasedEffect()
	float xDemeaned    = GetDemeanedEffect()
	float xDisgraced   = GetDisgracedEffect()

	float xShamed      = GetShamedEffect()
	float xSubmitted   = GetSubmittedEffect()
	float xHumiliated  = GetHumiliatedEffect()
	float xResignated  = GetResignatedEffect()
	
	float xmax = xDegraded
	if xAbused > xmax	
		xmax = xAbused
	endif
	if xObjectified > xmax	
		xmax = xObjectified
	endif
	if xTamed > xmax	
		xmax = xTamed
	endif
	if xForced > xmax	
		xmax = xForced
	endif
	if xdominated > xmax	
		xmax = xdominated
	endif
	if xSubjugated > xmax	
		xmax = xSubjugated
	endif
	if xTerrorized > xmax	
		xmax = xTerrorized
	endif
	if xEnslaved > xmax	
		xmax = xEnslaved
	endif
	if xSubdued > xmax	
		xmax = xSubdued
	endif
	if xDebased > xmax	
		xmax = xDebased
	endif
	if xDemeaned > xmax	
		xmax = xDemeaned
	endif
	if xDisgraced > xmax	
		xmax = xDisgraced
	endif
	if xShamed > xmax	
		xmax = xShamed
	endif
	if xSubmitted > xmax	
		xmax = xSubmitted
	endif
	if xHumiliated > xmax	
		xmax = xHumiliated
	endif
	if xResignated > xmax	
		xmax = xResignated
	endif
	
	if xmax < 50.0
		if GetMoodIndex() == 9 ; Broken
			return 7 ; dominated
		endif
		return 1
	endif
	
	if xDegraded >= xmax
		return 2
	endif
	if xAbused >= xmax	
		return 3
	endif
	if xObjectified >= xmax	
		return 4
	endif
	if xTamed >= xmax	
		return 5
	endif
	if xForced >= xmax	
		return 6
	endif
	if xdominated >= xmax	
		return 7
	endif
	if xSubjugated >= xmax	
		return 8
	endif
	if xTerrorized >= xmax	
		return 9
	endif
	if xEnslaved >= xmax	
		return 10
	endif
	if xSubdued >= xmax	
		return 11
	endif
	if xDebased >= xmax	
		return 12
	endif
	if xDemeaned >= xmax	
		return 13
	endif
	if xDisgraced >= xmax	
		return 14
	endif
	if xShamed >= xmax	
		return 15
	endif
	if xSubmitted >= xmax	
		return 16
	endif
	if xHumiliated >= xmax	
		return 17
	endif
	if xResignated >= xmax	
		return 18
	endif
	if GetMoodIndex() == 9 ; Broken
		return 7 ; dominated
	endif
	return 19
EndFunction

float Function GetSubmittedEffect()
	return submission+MOD_Orgasm*20.0 ; Training is between 0 and 100 - Modifier is between 0 and 5
EndFunction

float Function GetHumiliatedEffect()
	return humiliation+MOD_Orgasm*20.0
EndFunction

float Function GetResignatedEffect()
	return resignation+MOD_Addict*20.0
EndFunction

float Function GetShamedEffect()
	return (humiliation+submission)/2.0+MOD_Orgasm*20.0
EndFunction

float Function GetDegradedEffect() 
	return humiliation+submission
EndFunction

float Function GetAbusedEffect()
	return (submission+humiliation)/2.0+anger_training
EndFunction

float Function GetObjectifiedEffect()
	return (humiliation+resignation)/2.0+anger_training
EndFunction

float Function GetTamedEffect()
	return (resignation+submission)/2.0+anger_training
EndFunction

float Function GetForcedEffect()
	return submission+fear_training
EndFunction

float Function GetdominatedEffect()
	return submission+anger_training
EndFunction

float Function GetSubjugatedEffect()
	return submission+respect_training
EndFunction

float Function GetTerrorizedEffect()
	return resignation+fear_training
EndFunction

float Function GetEnslavedEffect()
	return resignation+anger_training
EndFunction

float Function GetSubduedEffect()
	return resignation+respect_training
EndFunction

float Function GetDebasedEffect()
	return humiliation+fear_training
EndFunction

float Function GetDemeanedEffect()
	return humiliation+anger_training
EndFunction

float Function GetDisgracedEffect()
	return humiliation+respect_training
EndFunction

; ### Promises

float Property promiseTimer = 0.0 Auto Hidden
string Property promiseOath = "nothing" Auto Hidden
int __promise_kept = 0
int Property promise_kept Hidden
	int Function get()
		return __promise_kept
	EndFunction
	Function set(int value)
		if __promise_kept == value
			return
		endif
		__promise_kept = value
		if __promise_kept == 1
			DOM01.DOM04.NotifyKeptPromise(actor_alias,promiseOath)
		endif
	EndFunction
EndProperty

bool Function PromiseWasKept()
	if promise_kept > 0
		return true
	endif
	return false
EndFunction

Function HandlePromiseOnUpdate()
	if promiseTimer == 0 || promiseOath == "nothing"
		return
	endif
	; else is not after timeout : hope
	float elapsed_time = GetCurrentGameTime()-promiseTimer
	if RandomFloat() < MOD_Hope
		TrainForPromiseOnUpdate(promiseOath)
	endif
	if elapsed_time < 1.0
		return
	endif
	if elapsed_time > 10.0 || RandomFloat() > MOD_Gentleness
		; end of belief
		TrainForPromiseOnEnd()
		TrainResignation(5.0)
		ClearPromise()
	endif
EndFunction

Function TrainForPromiseOnUpdate(string oath)
	;PrintTrainingBefore("promise update",1.0,promiseOath)
	if oath == "freedom"
		TrainForfreedom(2.0)
	elseif oath == "money"
		if promise_kept >= 0 ; no more effect if promise was broken
			TrainForGreed(2.0)
		endif
	elseif oath == "to be gentle"
		if promise_kept >= 0 ; no more effect if promise was broken
			TrainAnger(2.0)
		endif
	elseif oath == "rapture"
		if promise_kept >= 0
			TrainSubmission(0.5)
			TrainHumiliation(0.5)
		endif
	elseif oath == "to be sacrificed"
		TrainFear(1.0)
		MakeAngryFor(0.5)
	else ; if oath == "pain"
		TrainSubmission(0.5)
		TrainFear(0.5)
	endif
	;PrintTrainingAfter("promise update",1.0,promiseOath)
EndFunction

bool Function StartPromising(Actor akAbuser, string oath)
	abuse_type = "psychological"
	if promiseOath == oath
		return RenewPromise()
	elseif promiseOath != "nothing"
		if oath == "nothing"
			CancelPromise()
			return false
		endif
		return ChangePromise(oath)
	endif
	bool is_success = SetPromise(oath)
	if is_success
		time_last_abused = GetCurrentGameTime()
		time_last_resilience = time_last_abused
		if akAbuser == PlayerRef ; player
			DOM01.DOM04.NotifyStartPromise(actor_alias,oath)
			actor_alias.SendExternalEventSSB("Promised",oath,is_success)
		endif
	endif
	return is_success
EndFunction

bool Function SetPromise(string oath)
	promiseTimer = GetCurrentGameTime()
	promiseOath = oath
	promise_kept = 0
	if promiseOath == "freedom"
		akRef.SetFactionRank(DOM01.DOMPromised,1)
	elseif promiseOath == "money"
		akRef.SetFactionRank(DOM01.DOMPromised,2)
	elseif promiseOath == "to be gentle"
		akRef.SetFactionRank(DOM01.DOMPromised,3)
	elseif promiseOath == "pain"
		akRef.SetFactionRank(DOM01.DOMPromised,4)
	elseif promiseOath == "rapture"
		akRef.SetFactionRank(DOM01.DOMPromised,5)
	elseif promiseOath == "to be sacrificed"
		akRef.SetFactionRank(DOM01.DOMPromised,6)
	else
		ClearPromise()
		return false
	endif
	number_of_promise += 1
	return true
EndFunction

Function ClearPromise()
	number_of_promise += 1
	promiseTimer = GetCurrentGameTime()
	promiseOath = "nothing"
	promise_kept = 0
	akRef.RemoveFromFaction(DOM01.DOMPromised)
EndFunction

bool Function ChangePromise(string new_oath)
	;PrintTrainingBefore("promise change",1.0,promiseOath)
	; Change promise
	if promiseOath == "to be sacrificed"
		SendNotification(name+" is relieved "+actorPossessive+" sacrifice is cancelled")
		SendNotification(name+" welcomes your new promise to "+new_oath)
		actor_alias.ChooseAnswerFailedPromise(PlayerRef)
		TrainFear(5.0)
		MakeAngryFor(2.0)
		return SetPromise(new_oath)
	endif
	if promiseOath == "to be gentle"
		SendNotification(name+" was previously promised you would be gentle")	
	else
		SendNotification(name+" was previously promised "+promiseOath)	
	endif
	if IsDevoted()
		SendNotification(name+" understands it's better to change it to "+new_oath)
		return SetPromise(new_oath)
	endif
	if promise_kept <= 0
		SendNotification(name+" doesn't understand the need to change it to "+new_oath)
		DegradeRelationship()
		MakeAngryFor(5.0)
		actor_alias.ChooseAnswerFailedPromise(PlayerRef)
		TrainResignation(5.0)
	endif
	SetPromise(new_oath)
	;PrintTrainingAfter("promise change",1.0,promiseOath)
	return false
EndFunction

bool Function RenewPromise()
	float cur_time = GetCurrentGameTime()
	float elapsed_time = cur_time-promiseTimer
	if elapsed_time > 0.1 ; a bit more than every 2 hours is considered a new promise
		number_of_promise += 1
	endif
	promiseTimer = cur_time
	if promiseOath == "to be sacrificed"
		SendNotification(name+" is relieved "+actorPossessive+" sacrifice is delayed")
		TrainFear(5.0)
		MakeAngryFor(2.0)
		return true
	endif
	if IsDevoted()
		if promiseOath == "to be gentle"
			SendNotification(name+" understands more time is needed for you to be gentle")	
		else
			SendNotification(name+" understands more time is needed for "+promiseOath)
		endif
		return true
	endif
	return false 
	;DegradeRelationship()
	;if promiseOath == "to be gentle"
	;	SendNotification(name+" doesn't understand why you can't be gentle now")	
	;else
	;	SendNotification(name+" doesn't understand why you need more time for "+promiseOath)	
	;endif
	;MakeAngryFor(5.0)
	;TrainResignation(5.0)
	;endif
EndFunction

Function CancelPromise()
	; Cancel promise
	if promiseOath == "to be sacrificed"
		SendNotification(name+" is relieved "+actorPossessive+" sacrifice is cancelled")
	elseif promise_kept <= 0
		DegradeRelationship()
		if promiseOath == "to be gentle"
			SendNotification(name+" promise to be gentle was cancelled")	
		else
			SendNotification(name+" promise of "+promiseOath+" was cancelled")	
		endif
	else
		if promiseOath == "to be gentle"
			SendNotification(name+" promise to be gentle was ended")	
		else
			SendNotification(name+" promise of "+promiseOath+" was ended")	
		endif
	endif
	TrainForPromiseOnEnd()
	ClearPromise()
EndFunction

; ### Punishments

int Property ticks_since_last_hit = 0 Auto Hidden
float Property time_last_abused = 0.0 Auto Hidden
float Property time_last_resilience = 0.0 Auto Hidden
Function HandlePunishmentOnUpdate()
	if !whipping_active
		ticks_since_last_punished += 1
		OnResilienceUpdate()
		return
	endif
	
	if end_punishment_on_next_tick
		if end_punishment_on_next_tick && whipping_by_trainer == false
			;LogTrace("HandlePunishmentOnUpdate EndPunishing")
			DOM_Actor akTrainer = actor_alias.GetTrainer()
			if akTrainer != None && akTrainer.GetWhippedTraineeActor() == akRef
				EndPunishing(akTrainer.akRef,"pain") ; Trainer whipping ends here
			else
				EndPunishing(actor_alias.GetCurrentTrainer(),"pain") ; whipping ends here
			endif
		endif
	elseif ticks_since_last_hit > 0 ; at least 1 tick without pain
		end_punishment_on_next_tick = true
	endif
	ticks_since_last_punished = 0
	ticks_since_last_hit += 1
EndFunction

bool Property end_punishment_on_next_tick = false Auto Hidden
Int __ticks_since_last_punished = 1000
Int Property ticks_since_last_punished Hidden
	Int Function get()
		return __ticks_since_last_punished
	EndFunction
	Function set(Int value)
		if __ticks_since_last_punished == value
			return
		endif
		__ticks_since_last_punished = value
		; Update dependencies
		SetChanceRecentlyPunished()
	EndFunction
EndProperty

; ### Kinks
; Kinks: hidden kinks added to personality: turned on by stripping, being rip-off clothes, choked/choking, whipped/whipping, public humiliation, anal, oral, raped/raping, 

int effect_kinks_nb = 0
float effect_kinks_max = 0.0
int effect_kinks_idx = 0
float[] _effect_kinks_slot
float[] Property effect_kinks_slot
	float[] Function Get()	
		if !_effect_kinks_slot
			_effect_kinks_slot = new float[128] ; total number of kinks is 128
			effect_kinks_nb = 128
		endif
		return _effect_kinks_slot
	EndFunction
EndProperty

int hidden_kinks_nb = -1
Int[] _hidden_kinks_slot
Int[] Property hidden_kinks_slot
	Int[] Function Get()	
		if !_hidden_kinks_slot
			_hidden_kinks_slot = new Int[8] ; limited to 8, that's a good number
			hidden_kinks_nb = 0
		elseif _hidden_kinks_slot.length < 8
			Int[] tmp_array = new Int[8]
			int i=0
			while i<tmp_array.length && i<_hidden_kinks_slot.length
				tmp_array[i] = _hidden_kinks_slot[i]
				i+=1
			endwhile
			_hidden_kinks_slot = new Int[8]
			hidden_kinks_nb = 0
			i = 0
			while i<tmp_array.length
				int k = tmp_array[i]
				if k > 0
					AddHiddenKink(k)
				endif
				i+=1
			endwhile
		endif
		return _hidden_kinks_slot
	EndFunction
EndProperty

int known_kinks_nb = 0
Int[] _known_kinks_slot
Int[] Property known_kinks_slot
	Int[] Function Get()	
		if !_known_kinks_slot
			_known_kinks_slot = new Int[8] ; limited to 8, that's a good number
			known_kinks_nb = 0
		elseif _known_kinks_slot.length < 8
			Int[] tmp_array = new Int[8]
			int i=0
			while i<tmp_array.length && i<_known_kinks_slot.length
				tmp_array[i] = _known_kinks_slot[i]
				i+=1
			endwhile
			_known_kinks_slot = new Int[8]
			known_kinks_nb = 0
			i = 0
			while i<tmp_array.length
				int k = tmp_array[i]
				if k > 0
					AddKnownKink(k)
				endif
				i+=1
			endwhile
		endif
		return _known_kinks_slot
	EndFunction
EndProperty

int Function GetNumberOfHiddenKinks()
	return hidden_kinks_nb
EndFunction

int Function GetMaxTeasedKink()
	return effect_kinks_idx
EndFunction

float Function GetMaxTeasedLevel()
	return effect_kinks_max
EndFunction

string Function GetListOfHiddenKinks()
	string msg = ""
	string sep = ""
	int n = hidden_kinks_slot.length
	int i = 0
	while i < n
		int ikink = _hidden_kinks_slot[i]
		if ikink > 0
			msg += sep + DOM01.GetJSONKinkReasonNameByIndex(ikink,actorSex)
			sep = ", "
		endif
		i += 1
	endwhile
	return msg
EndFunction

int Function GetNumberOfKnownKinks()
	return known_kinks_nb
EndFunction

int Function GetAnyHiddenKink()
	int n = hidden_kinks_nb
	int m = known_kinks_nb
	;LogTrace("GetAnyHiddenKink "+" known="+m+" / hidden="+n)
	if m >= n
		return (-1)
	endif
	int i = RandomInt(0,n-(1))
	int istart = i
	int ikink = hidden_kinks_slot[i]
	while HasKnownKink(ikink) && istart < n
		;LogTrace("GetAnyHiddenKink "+" found known kink "+i+" kink="+ikink)
		i += 1
		if i >= n
			i = 0
		endif
		ikink = hidden_kinks_slot[i]
		if i == istart
			istart = n
			ikink = (-1)
		endif
	endwhile
	;LogTrace("GetAnyHiddenKink "+" found hidden kink "+i+" kink="+ikink)
	return ikink
EndFunction

string Function GetListOfKnownKinks()
	string msg = ""
	string sep = ""
	int n = known_kinks_slot.length
	int i = 0
	while i < n
		int ikink = _known_kinks_slot[i]
		if ikink > 0
			msg += sep + DOM01.GetJSONKinkReasonNameByIndex(ikink,actorSex)
			sep = ", "
		endif
		i += 1
	endwhile
	return msg
EndFunction

Function ResetKinks()
	if hidden_kinks_nb >= 0
		return
	endif
	;LogTrace("ResetKinks()")
	SetKinks(0)
EndFunction

Function SetHiddenKinksFromFactions()
	int kink
	string name_kink
	int check_kink
	if akRef.IsInFaction(DOM01.DOMHiddenKink0)
		kink = akRef.GetFactionRank(DOM01.DOMHiddenKink0)
		if kink > 1 && kink < 127 && !HasHiddenKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddHiddenKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink1)
		kink = akRef.GetFactionRank(DOM01.DOMHiddenKink1)
		if kink > 1 && kink < 127 && !HasHiddenKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddHiddenKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink2)
		kink = akRef.GetFactionRank(DOM01.DOMHiddenKink2)
		if kink > 1 && kink < 127 && !HasHiddenKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddHiddenKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink3)
		kink = akRef.GetFactionRank(DOM01.DOMHiddenKink3)
		if kink > 1 && kink < 127 && !HasHiddenKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddHiddenKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink4)
		kink = akRef.GetFactionRank(DOM01.DOMHiddenKink4)
		if kink > 1 && kink < 127 && !HasHiddenKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddHiddenKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink5)
		kink = akRef.GetFactionRank(DOM01.DOMHiddenKink5)
		if kink > 1 && kink < 127 && !HasHiddenKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddHiddenKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink6)
		kink = akRef.GetFactionRank(DOM01.DOMHiddenKink6)
		if kink > 1 && kink < 127 && !HasHiddenKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddHiddenKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink7)
		kink = akRef.GetFactionRank(DOM01.DOMHiddenKink7)
		if kink > 1 && kink < 127 && !HasHiddenKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddHiddenKink(kink)
			endif
		endif
	endif
EndFunction

Function SetKnownKinksFromFactions()
	int kink
	string name_kink
	int check_kink
	if akRef.IsInFaction(DOM01.DOMKnownKink0)
		kink = akRef.GetFactionRank(DOM01.DOMKnownKink0)
		if kink > 1 && kink < 127 && HasHiddenKink(kink) && !HasKnownKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddKnownKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink1)
		kink = akRef.GetFactionRank(DOM01.DOMKnownKink1)
		if kink > 1 && kink < 127 && HasHiddenKink(kink) && !HasKnownKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddKnownKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink2)
		kink = akRef.GetFactionRank(DOM01.DOMKnownKink2)
		if kink > 1 && kink < 127 && HasHiddenKink(kink) && !HasKnownKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddKnownKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink3)
		kink = akRef.GetFactionRank(DOM01.DOMKnownKink3)
		if kink > 1 && kink < 127 && HasHiddenKink(kink) && !HasKnownKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddKnownKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink4)
		kink = akRef.GetFactionRank(DOM01.DOMKnownKink4)
		if kink > 1 && kink < 127 && HasHiddenKink(kink) && !HasKnownKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddKnownKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink5)
		kink = akRef.GetFactionRank(DOM01.DOMKnownKink5)
		if kink > 1 && kink < 127 && HasHiddenKink(kink) && !HasKnownKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddKnownKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink6)
		kink = akRef.GetFactionRank(DOM01.DOMKnownKink6)
		if kink > 1 && kink < 127 && HasHiddenKink(kink) && !HasKnownKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddKnownKink(kink)
			endif
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink7)
		kink = akRef.GetFactionRank(DOM01.DOMKnownKink7)
		if kink > 1 && kink < 127 && HasHiddenKink(kink) && !HasKnownKink(kink)
			name_kink = DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex)
			check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
			if check_kink == kink
				AddKnownKink(kink)
			endif
		endif
	endif
EndFunction

Function SetHiddenKinksFromJSON(int nkinksJSON)
	LogTrace("SetHiddenKinksFromJSON n="+nkinksJSON)
	int kmax = hidden_kinks_slot.length
	if nkinksJSON <= 0
		nkinksJSON = DOM01.DOMGenerator.GetHiddenKinksNumber(akRef,actorSex,kmax)
	endif
	if nkinksJSON <= 0
		return
	endif

	int i = 0
	while i < kmax 
		int kink = DOM01.DOMGenerator.GetHiddenKink(akRef,actorSex,i)
		if kink > 0
			LogTrace("SetHiddenKinksFromJSON get kink="+kink)
			AddHiddenKink(kink)
		endif
		i += 1
	endwhile
EndFunction

Function SetHiddenKinksRandom()
	int nb_rand = GetNumberOfKinks(akRef) - hidden_kinks_nb
	if is_player_actor && !DOM01.kinksPlayerSubToggle && !DOM01.kinksPlayerDomToggle
		nb_rand = 0
	endif
	LogTrace("SetHiddenKinksRandom n="+nb_rand)
	if nb_rand <= 0
		return
	endif
	if nb_rand > hidden_kinks_slot.length
		nb_rand = hidden_kinks_slot.length ; Max 8 kinks
	endif
	;LogTrace("SetHiddenKinksRandom() number of new kinks="+nb_rand+" previously="+hidden_kinks_nb+" submissivity="+FACET_Submissivity)
	int i = 0;
	int itry = 0
	int the_kink = 0
	while i<nb_rand
		if RandomFloat()*100.0 < FACET_Submissivity+25.0
			the_kink = RandomInt(1,80) ; submissive kink
		else
			the_kink = RandomInt(81,126) ; Dominant kink
		endif
		string name_kink = DOM01.GetJSONKinkReasonNameByIndex(the_kink,actorSex)
		int check_kink = DOM01.GetJSONKinkReasonIndexByName(name_kink)
		if check_kink == the_kink && DOM01.FilterKink(check_kink,actorSex,akRef)
			LogTrace("SetHiddenKinksRandom get kink="+the_kink)
			AddHiddenKink(the_kink)
			i += 1
			itry = 0
		else
			;LogTrace("AddHiddenKink() FAILED "+name+" n="+hidden_kinks_nb+" wrong kink="+the_kink+" "+DOM01.GetJSONKinkReasonNameByIndex(the_kink,actorSex)+" tries="+itry)	
			itry += 1
			if itry > 10
				i+=1
				itry = 0
			endif
		endif
	endwhile
EndFunction

Function ClearKinks()
	; Clear data
	int n = effect_kinks_slot.Length
	int i = 0
	while i < n
		_effect_kinks_slot[i] = 0
		i+=1
	endwhile
	effect_kinks_nb = 0
	effect_kinks_max = 0.0
	effect_kinks_idx = 0
	n = known_kinks_slot.Length
	i = 0
	while i < n
		_known_kinks_slot[i] = 0
		i+=1
	endwhile
	known_kinks_nb = 0
	n = hidden_kinks_slot.Length
	i = 0
	while i < n
		_hidden_kinks_slot[i] = 0
		i+=1
	endwhile
	hidden_kinks_nb = -1
	
	; Clear hidden kink factions
	if akRef.IsInFaction(DOM01.DOMHiddenKink0)
		akRef.RemoveFromFaction(DOM01.DOMHiddenKink0)
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink1)
		akRef.RemoveFromFaction(DOM01.DOMHiddenKink1)
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink2)
		akRef.RemoveFromFaction(DOM01.DOMHiddenKink2)
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink3)
		akRef.RemoveFromFaction(DOM01.DOMHiddenKink3)
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink4)
		akRef.RemoveFromFaction(DOM01.DOMHiddenKink4)
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink5)
		akRef.RemoveFromFaction(DOM01.DOMHiddenKink5)
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink6)
		akRef.RemoveFromFaction(DOM01.DOMHiddenKink6)
	endif
	if akRef.IsInFaction(DOM01.DOMHiddenKink7)
		akRef.RemoveFromFaction(DOM01.DOMHiddenKink7)
	endif
	
	; Clear known kink factions
	if akRef.IsInFaction(DOM01.DOMKnownKink0)
		akRef.RemoveFromFaction(DOM01.DOMKnownKink0)
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink1)
		akRef.RemoveFromFaction(DOM01.DOMKnownKink1)
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink2)
		akRef.RemoveFromFaction(DOM01.DOMKnownKink2)
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink3)
		akRef.RemoveFromFaction(DOM01.DOMKnownKink3)
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink4)
		akRef.RemoveFromFaction(DOM01.DOMKnownKink4)
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink5)
		akRef.RemoveFromFaction(DOM01.DOMKnownKink5)
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink6)
		akRef.RemoveFromFaction(DOM01.DOMKnownKink6)
	endif
	if akRef.IsInFaction(DOM01.DOMKnownKink7)
		akRef.RemoveFromFaction(DOM01.DOMKnownKink7)
	endif
EndFunction

Function SetKinks(int nkinksJSON)
	if hidden_kinks_nb >= hidden_kinks_slot.length
		SetKnownKinksFromFactions()
		return
	endif
	
	if hidden_kinks_nb < 0
		hidden_kinks_nb = 0
	endif
	
	SetHiddenKinksFromFactions()
	if hidden_kinks_nb >= hidden_kinks_slot.length
		SetKnownKinksFromFactions()
		return
	endif
	
	SetHiddenKinksFromJSON(nkinksJSON)
	if hidden_kinks_nb >= hidden_kinks_slot.length
		SetKnownKinksFromFactions()
		return
	endif
	
	SetHiddenKinksRandom()
	SetKnownKinksFromFactions()
EndFunction

Function AddHiddenKink(int the_kink)
	LogTrace("AddHiddenKink try to add kink n="+hidden_kinks_nb+" "+the_kink+" "+DOM01.GetJSONKinkReasonNameByIndex(the_kink,actorSex))	
	int i = 0
	int n = hidden_kinks_slot.length
	while i < n
		int kink = _hidden_kinks_slot[i]
		if kink <= 0
			AddHiddenKinkInSlot(i,the_kink)
			return
		endif
		if kink == the_kink
			return ; already registered
		endif
		i += 1
	endwhile
	; Kink was not registered because array was full...
	; if minor kink skip
	if IsSmallKink(the_kink)
		return
	endif
	;LogTrace("AddHiddenKink() try to add major kink n="+hidden_kinks_nb+" "+the_kink+" "+DOM01.GetJSONKinkReasonNameByIndex(the_kink,actorSex))	
	; if major kink try again
	i = 0
	while i < n
		int kink = hidden_kinks_slot[i]
		if IsSmallKink(kink)
			AddHiddenKinkInSlot(i,the_kink)
			return
		endif
		if kink == the_kink
			return ; already registered
		endif
		i += 1
	endwhile
	; Still not registered, forget it
EndFunction

Function AddHiddenKinkInSlot(int slot, int kink)
	if kink <= 0
		return
	endif
	if hidden_kinks_slot[slot] <= 0
		hidden_kinks_nb += 1
	endif
	hidden_kinks_slot[slot] = kink
	if slot == 0
		akRef.SetFactionRank(DOM01.DOMHiddenKink0,kink)
		;LogTrace("AddHiddenKinkInSlot() "+name+" kink0="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))			
	elseif slot == 1
		akRef.SetFactionRank(DOM01.DOMHiddenKink1,kink)
		;LogTrace("AddHiddenKinkInSlot() "+name+" kink1="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	elseif slot == 2
		akRef.SetFactionRank(DOM01.DOMHiddenKink2,kink)
		;LogTrace("AddHiddenKinkInSlot() "+name+" kink2="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	elseif slot == 3
		akRef.SetFactionRank(DOM01.DOMHiddenKink3,kink)
		;LogTrace("AddHiddenKinkInSlot() "+name+" kink3="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	elseif slot == 4
		akRef.SetFactionRank(DOM01.DOMHiddenKink4,kink)
		;LogTrace("AddHiddenKinkInSlot() "+name+" kink4="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	elseif slot == 5
		akRef.SetFactionRank(DOM01.DOMHiddenKink5,kink)
		;LogTrace("AddHiddenKinkInSlot() "+name+" kink5="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	elseif slot == 6
		akRef.SetFactionRank(DOM01.DOMHiddenKink6,kink)
		;LogTrace("AddHiddenKinkInSlot() "+name+" kink6="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	elseif slot == 7
		akRef.SetFactionRank(DOM01.DOMHiddenKink7,kink)
		;LogTrace("AddHiddenKinkInSlot() "+name+" kink7="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	endif
EndFunction

Function AddKnownKink(int the_kink)
	LogTrace("AddKnownKink() try to add kink n="+known_kinks_nb+" "+the_kink+" "+DOM01.GetJSONKinkReasonNameByIndex(the_kink,actorSex))	
	int i = 0
	int n = known_kinks_slot.length
	while i < n
		int kink = _known_kinks_slot[i]
		if kink <= 0
			AddKnownKinkInSlot(i,the_kink)
			return
		endif
		if kink == the_kink
			return ; already registered
		endif
		i += 1
	endwhile
	; Kink was not registered because array was full...
EndFunction

Function AddKnownKinkInSlot(int slot, int kink)
	if kink <= 0
		return
	endif
	if known_kinks_slot[slot] <= 0
		known_kinks_nb += 1
	endif
	known_kinks_slot[slot] = kink
	if slot == 0
		akRef.SetFactionRank(DOM01.DOMKnownKink0,kink)
		;LogTrace("AddKnownKinkInSlot() "+name+" kink0="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))			
	elseif slot == 1
		akRef.SetFactionRank(DOM01.DOMKnownKink1,kink)
		;LogTrace("AddKnownKinkInSlot() "+name+" kink1="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	elseif slot == 2
		akRef.SetFactionRank(DOM01.DOMKnownKink2,kink)
		;LogTrace("AddKnownKinkInSlot() "+name+" kink2="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	elseif slot == 3
		akRef.SetFactionRank(DOM01.DOMKnownKink3,kink)
		;LogTrace("AddKnownKinkInSlot() "+name+" kink3="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	elseif slot == 4
		akRef.SetFactionRank(DOM01.DOMKnownKink4,kink)
		;LogTrace("AddKnownKinkInSlot() "+name+" kink4="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	elseif slot == 5
		akRef.SetFactionRank(DOM01.DOMKnownKink5,kink)
		;LogTrace("AddKnownKinkInSlot() "+name+" kink5="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	elseif slot == 6
		akRef.SetFactionRank(DOM01.DOMKnownKink6,kink)
		;LogTrace("AddKnownKinkInSlot() "+name+" kink6="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	elseif slot == 7
		akRef.SetFactionRank(DOM01.DOMKnownKink7,kink)
		;LogTrace("AddKnownKinkInSlot() "+name+" kink7="+kink+" "+DOM01.GetJSONKinkReasonNameByIndex(kink,actorSex))				
	endif
EndFunction

bool Function HasHiddenKink(int the_kink)
	if !is_player_slave || !is_slave
		return false
	endif
	if hidden_kinks_nb <= 0
		return false
	endif

	int i = 0
	int n = hidden_kinks_slot.length
	while i < n
		int kink = _hidden_kinks_slot[i]
		if kink <= 0
			return false
		endif
		if kink == the_kink
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

bool Function HasKnownKink(int the_kink)
	if known_kinks_nb <= 0
		return false
	endif

	int i = 0
	int n = known_kinks_slot.length
	while i < n
		int kink = _known_kinks_slot[i]
		if kink <= 0
			return false
		endif
		if kink == the_kink
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

Function CheckAndRegisterKink(int the_kink, float w)
	if the_kink <= 0 || the_kink >= 127
		return
	endif
	bool has_kink = HasHiddenKink(the_kink)
	RegisterEffectKink(has_kink,the_kink,w)
	if !has_kink
		return
	endif
	DiscoverHiddenKink(the_kink,1.0+w)
	TrainForKink(w,the_kink)
EndFunction

Function RegisterEffectKink(bool has_kink, int the_kink, float w)
	if !DOM01.FilterKink(the_kink,actorSex,None)
		return
	endif
	float n = effect_kinks_slot[the_kink] + w
	_effect_kinks_slot[the_kink] = n
	if has_kink
		return
	endif
	if n < effect_kinks_max
		return
	endif
	effect_kinks_max = n
	effect_kinks_idx = the_kink
	if hidden_kinks_nb >= hidden_kinks_slot.length || n < 12.0 ; starts after 12 times
		return
	endif
	float x = RandomFloat()*50.0+50.0
	float chance = n*(MOD_Orgasm+MOD_Impressionable)
	if mood == "shock"
		chance = chance * (1.0 + MOD_Addict)
	endif
	;LogTrace("Teasing "+GetMoodNameThirdPerson()+name+" with "+DOM01.GetJSONKinkReasonNameByIndex(the_kink,actorSex)+" chance="+chance+" rnd="+x)
	if chance < 10.0
		return
	endif
	SendNotificationEmotion("Teasing "+GetMoodNameThirdPerson()+name+" with "+DOM01.GetJSONKinkReasonNameByIndex(the_kink,actorSex))
	float chance_prev = (n-(1))*(MOD_Orgasm+MOD_Impressionable)
	if chance >= 30.0 && chance_prev < 30.0
		string kink_name = DOM01.GetJSONKinkReasonNameByIndex(the_kink,actorSex)
		DOM01.DOM04.NotifyTeasingKink(actor_alias,kink_name)
	endif
	if chance > x
		effect_kinks_max = 0.0
		AddHiddenKink(the_kink)
		if mood == "shock" ; try to recover from shock
			ChooseMoodChange()
		endif
		string kink_name = DOM01.GetJSONKinkReasonNameByIndex(the_kink,actorSex)
		DOM01.DOM04.NotifyAcquiredKink(actor_alias,kink_name)
	endif
EndFunction

Function DiscoverHiddenKink(int the_kink,float w)
	number_of_kinktrigger += 1
	if HasKnownKink(the_kink)
		SendNotificationEmotion("Confusing "+GetMoodNameThirdPerson()+name+" with "+actorObjective+" kink of "+DOM01.GetJSONKinkReasonNameByIndex(the_kink,actorSex))
		IncreaseArousal(10.0*DOM01.arousal_speed_kink,MOD_Ingenuity*w)
		return
	endif
	if hidden_kinks_nb <= 0
		return
	endif
	AddKnownKink(the_kink)
	string kink_name = DOM01.GetJSONKinkReasonNameByIndex(the_kink,actorSex)
	SendNotificationAbuse("Humiliating "+GetMoodNameThirdPerson()+name+" with the discovery of "+actorObjective+" kink of "+kink_name)
	IncreaseArousal(50.0*DOM01.arousal_speed_kink,MOD_Ingenuity*w)
	if IsOrgasmingAfterArousal((0.2+MOD_Ingenuity*w)*DOM01.orgasm_speed_kink)
		actor_alias.SendExternalEventSS("Orgasm","kink")
	endif
	actor_alias.SendExternalEventSS("KinkDiscovered",kink_name)
	DOM01.DOM04.NotifyDiscoverKink(actor_alias,kink_name)
EndFunction

Function CheckRestrainedKinks(string the_pose)
	if hidden_kinks_nb <= 0 && known_kinks_nb <= 0
		return
	endif
	if the_pose == ""
		CheckAndRegisterKink(22,2.0) ; "being tied-up" 
	elseif DOM01.DOM_Anim.IsPoseTiedUp(the_pose)
		CheckAndRegisterKink(22,2.0) ; "being tied-up"
	elseif DOM01.DOM_Anim.IsPoseChain(the_pose)
		CheckAndRegisterKink(28,2.0) ; "being chained"
	elseif DOM01.DOM_Anim.IsPosePost(the_pose)
		CheckAndRegisterKink(27,2.0) ; "being tied to the post"
	elseif DOM01.DOM_Anim.IsPoseWheel(the_pose)
		CheckAndRegisterKink(26,2.0) ; "being tied to the wheel"
	elseif DOM01.DOM_Anim.IsPoseCross(the_pose)
		CheckAndRegisterKink(25,2.0) ; "being tied to the cross"
	elseif DOM01.DOM_Anim.IsPoseCage(the_pose)
		CheckAndRegisterKink(24,2.0) ; "being caged"
	elseif DOM01.DOM_Anim.IsPosePillory(the_pose)
		CheckAndRegisterKink(23,2.0) ; "being sent to the pillory"
	elseif DOM01.DOM_Anim.IsPoseHogtied(the_pose)
		CheckAndRegisterKink(91,2.0) ; "being hogtied"
	elseif DOM01.DOM_Anim.IsPoseHanging(the_pose)
		CheckAndRegisterKink(92,2.0) ; "being hung"
	elseif DOM01.DOM_Anim.IsPoseTiedInBed(the_pose)
		CheckAndRegisterKink(93,2.0) ; "being tied to a bed"
	elseif StringUtil.Find(the_pose, "Pillory")>=0
		CheckAndRegisterKink(23,2.0) ; "being sent to the pillory"
	elseif StringUtil.Find(the_pose, "Wheel")>=0
		CheckAndRegisterKink(26,2.0) ; "being tied to the wheel"
	elseif StringUtil.Find(the_pose, "Cage")>=0
		CheckAndRegisterKink(24,2.0) ; "being caged"
	elseif StringUtil.Find(the_pose, "Cross")>=0
		CheckAndRegisterKink(25,2.0) ; "being tied to the cross"
	elseif StringUtil.Find(the_pose, "Post")>=0
		CheckAndRegisterKink(27,2.0) ; "being tied to the post"
	elseif StringUtil.Find(the_pose, "Chain")>=0
		CheckAndRegisterKink(28,2.0) ; "being chained"
	else ; Probably DM3 or Zaz devices
		CheckAndRegisterKink(90,2.0) ; "being locked in  a device"
	endif
EndFunction

; ### Personality index to select poses

int personality_index = -1
float property Sum_HEXACO = 0.0 Auto Hidden
float property Sum_FACET = 0.0 Auto Hidden

int Function GetPersonalityIndex()
	if personality_index >= 0
		return personality_index
	endif
	personality_index = ComputePersonalityIndex()
	return personality_index
EndFunction

Function UpdatePersonalityIndex()
	;LogTrace("UpdatePersonalityIndex old index="+personality_index)
	int new_personality_index = ComputePersonalityIndex()
	if new_personality_index != personality_index
		personality_index = new_personality_index
		LogTrace("UpdatePersonalityIndex new index="+personality_index)
	endif
EndFunction

int Function ComputePersonalityIndex()
	; Personality sums
	Sum_HEXACO = HEXACO_Honesty + HEXACO_Emotionality + HEXACO_eXtraversion + HEXACO_Agreeableness + HEXACO_Conscientiousness + HEXACO_Openness
	Sum_FACET  = FACET_Wilfulness + FACET_Toughness + FACET_Sensuality + FACET_Submissivity + FACET_Boldness + FACET_Smartness

	; Strong personality
	if FACET_Smartness > 92.0 && HEXACO_Honesty < 8.0
		return  1 ; Manipulative
	endif
	if FACET_Submissivity > 92.0 && HEXACO_Emotionality < 8.0
		return 2 ; Apathetic
	endif
	if FACET_Sensuality > 92.0 && HEXACO_eXtraversion < 8.0
		return 3 ; Languid
	endif
	if FACET_Wilfulness > 92.0 && HEXACO_Agreeableness < 8.0
		return 4 ; Obstinate
	endif
	if FACET_Toughness > 92.0 && HEXACO_Conscientiousness < 8.0
		return 5 ; Reckless
	endif
	if FACET_Boldness > 92.0 && HEXACO_Openness < 8.0
		return 6 ; Brash
	endif
	if Sum_FACET > 500.0 && Sum_HEXACO < 100.0
		return 7 ; Ruthless
	endif

	if FACET_Smartness < 8.0 && HEXACO_Honesty < 8.0
		return 8 ; Shiftless
	endif
	if FACET_Submissivity < 8.0 && HEXACO_Emotionality < 8.0
		return 9 ; Commanding
	endif
	if FACET_Sensuality < 8.0 && HEXACO_eXtraversion < 8.0
		return 10 ; Austere
	endif
	if FACET_Wilfulness < 8.0 && HEXACO_Agreeableness < 8.0
		return 11 ; Listless
	endif
	if FACET_Toughness < 8.0 && HEXACO_Conscientiousness < 8.0
		return 12 ; Feckless
	endif
	if FACET_Boldness < 8.0 && HEXACO_Openness < 8.0
		return 13 ; Conventional
	endif
	if Sum_FACET < 100.0 && Sum_HEXACO < 100.0
		return 14 ; Stolid
	endif

	if FACET_Smartness < 8.0 && HEXACO_Honesty > 92.0
		return 15 ; Guileless
	endif
	if FACET_Submissivity < 8.0 && HEXACO_Emotionality > 92.0
		return 16 ; Fiery
	endif
	if FACET_Sensuality < 8.0 && HEXACO_eXtraversion > 92.0
		return 17 ; Exuberant
	endif
	if FACET_Wilfulness < 8.0 && HEXACO_Agreeableness > 92.0
		return 18 ; Meek
	endif
	if FACET_Toughness < 8.0 && HEXACO_Conscientiousness > 92.0
		return 19 ; Delicate
	endif
	if FACET_Boldness < 8.0 && HEXACO_Openness > 92.0
		return 20 ; Contemplative
	endif
	if Sum_FACET < 100.0 && Sum_HEXACO > 500.0
		return 21 ; Lambent
	endif

	if FACET_Smartness > 92.0 && HEXACO_Honesty > 92.0
		return 22 ; Wise
	endif
	if FACET_Submissivity > 92.0 && HEXACO_Emotionality > 92.0
		return 23 ; Timid
	endif
	if FACET_Sensuality > 92.0 && HEXACO_eXtraversion > 92.0
		return 24 ; Vivacious
	endif
	if FACET_Wilfulness > 92.0 && HEXACO_Agreeableness > 92.0
		return 25 ; Steadfast
	endif
	if FACET_Toughness > 92.0 && HEXACO_Conscientiousness > 92.0
		return 26 ; Stoic
	endif
	if FACET_Boldness > 92.0 && HEXACO_Openness > 92.0
		return 27 ; Audacious
	endif
	if Sum_FACET > 500.0 && Sum_HEXACO > 500.0
		return 28 ; Magnanimous
	endif

	; Medium personality
	if FACET_Smartness > 84.0 && HEXACO_Honesty < 16.0
		return 1 ; Manipulative
	endif
	if FACET_Submissivity > 84.0 && HEXACO_Emotionality < 16.0
		return 2 ; Apathetic
	endif
	if FACET_Sensuality > 84.0 && HEXACO_eXtraversion < 16.0
		return 3 ; Languid
	endif
	if FACET_Wilfulness > 84.0 && HEXACO_Agreeableness < 16.0
		return 4 ; Obstinate
	endif
	if FACET_Toughness > 84.0 && HEXACO_Conscientiousness < 16.0
		return 5 ; Reckless
	endif
	if FACET_Boldness > 84.0 && HEXACO_Openness < 16.0
		return 6 ; Brash
	endif
	if Sum_FACET > 400.0 && Sum_HEXACO < 200.0
		return 7 ; Ruthless
	endif

	if FACET_Smartness < 16.0 && HEXACO_Honesty < 16.0
		return 8 ; Shiftless
	endif
	if FACET_Submissivity < 16.0 && HEXACO_Emotionality < 16.0
		return 9 ; Commanding
	endif
	if FACET_Sensuality < 16.0 && HEXACO_eXtraversion < 16.0
		return 10 ; Austere
	endif
	if FACET_Wilfulness < 16.0 && HEXACO_Agreeableness < 16.0
		return 11 ; Listless
	endif
	if FACET_Toughness < 16.0 && HEXACO_Conscientiousness < 16.0
		return 12 ; Feckless
	endif
	if FACET_Boldness < 16.0 && HEXACO_Openness < 16.0
		return 13 ; Conventional
	endif
	if Sum_FACET < 200.0 && Sum_HEXACO < 200.0
		return 14 ; Stolid
	endif

	if FACET_Smartness < 16.0 && HEXACO_Honesty > 84.0
		return 15 ; Guileless
	endif
	if FACET_Submissivity < 16.0 && HEXACO_Emotionality > 84.0
		return 16 ; Fiery
	endif
	if FACET_Sensuality < 16.0 && HEXACO_eXtraversion > 84.0
		return 17 ; Exuberant
	endif
	if FACET_Wilfulness < 16.0 && HEXACO_Agreeableness > 84.0
		return 18 ; Meek
	endif
	if FACET_Toughness < 16.0 && HEXACO_Conscientiousness > 84.0
		return 19 ; Delicate
	endif
	if FACET_Boldness < 16.0 && HEXACO_Openness > 84.0
		return 20 ; Contemplative
	endif
	if Sum_FACET < 200.0 && Sum_HEXACO > 400.0
		return 21 ; Lambent
	endif
	
	if FACET_Smartness > 84.0 && HEXACO_Honesty > 84.0
		return 22 ; Wise
	endif
	if FACET_Submissivity > 84.0 && HEXACO_Emotionality > 84.0
		return 23 ; Timid
	endif
	if FACET_Sensuality > 84.0 && HEXACO_eXtraversion > 84.0
		return 24 ; Vivacious
	endif
	if FACET_Wilfulness > 84.0 && HEXACO_Agreeableness > 84.0
		return 25 ; Steadfast
	endif
	if FACET_Toughness > 84.0 && HEXACO_Conscientiousness > 84.0
		return 26 ; Stoic
	endif
	if FACET_Boldness > 84.0 && HEXACO_Openness > 84.0
		return 27 ; Audacious
	endif
	if Sum_FACET > 500.0 && Sum_HEXACO > 500.0
		return 28 ; Magnanimous
	endif
	
	; Faint personality
	if FACET_Smartness > 66.0 && HEXACO_Honesty < 34.0
		return 1 ; Manipulative
	endif
	if FACET_Submissivity > 66.0 && HEXACO_Emotionality < 34.0
		return 2 ; Apathetic
	endif
	if FACET_Sensuality > 66.0 && HEXACO_eXtraversion < 34.0
		return 3 ; Languid 
	endif
	if FACET_Wilfulness > 66.0 && HEXACO_Agreeableness < 34.0
		return 4 ; Obstinate
	endif
	if FACET_Toughness > 66.0 && HEXACO_Conscientiousness < 34.0
		return 5 ; Reckless
	endif
	if FACET_Boldness > 66.0 && HEXACO_Openness < 34.0
		return 6 ; Brash
	endif
	
	if FACET_Smartness < 34.0 && HEXACO_Honesty < 34.0
		return 8 ; Shiftless
	endif
	if FACET_Submissivity < 34.0 && HEXACO_Emotionality < 34.0
		return 9 ; Commanding
	endif
	if FACET_Sensuality < 34.0 && HEXACO_eXtraversion < 34.0
		return 10 ; Austere
	endif
	if FACET_Wilfulness < 34.0 && HEXACO_Agreeableness < 34.0
		return 11 ; Listless
	endif
	if FACET_Toughness < 34.0 && HEXACO_Conscientiousness < 34.0
		return 12 ; Feckless
	endif
	if FACET_Boldness < 34.0 && HEXACO_Openness < 34.0
		return 13 ; Conventional
	endif

	if FACET_Smartness < 34.0 && HEXACO_Honesty > 66.0
		return 15 ; Guileless
	endif
	if FACET_Submissivity < 34.0 && HEXACO_Emotionality > 66.0
		return 16 ; Fiery
	endif
	if FACET_Sensuality < 34.0 && HEXACO_eXtraversion > 66.0
		return 17 ; Exuberant
	endif
	if FACET_Wilfulness < 34.0 && HEXACO_Agreeableness > 66.0
		return 18 ; Meek
	endif
	if FACET_Toughness < 34.0 && HEXACO_Conscientiousness > 66.0
		return 19 ; Delicate
	endif
	if FACET_Boldness < 34.0 && HEXACO_Openness > 66.0
		return 20 ; Contemplative
	endif

	if FACET_Smartness > 66.0 && HEXACO_Honesty > 66.0
		return 22 ; Wise
	endif
	if FACET_Submissivity > 66.0 && HEXACO_Emotionality > 66.0
		return 23 ; Timid
	endif
	if FACET_Sensuality > 66.0 && HEXACO_eXtraversion > 66.0
		return 24 ; Vivacious
	endif
	if FACET_Wilfulness > 66.0 && HEXACO_Agreeableness > 66.0
		return 25 ; Steadfast
	endif
	if FACET_Toughness > 66.0 && HEXACO_Conscientiousness > 66.0
		return 26 ; Stoic
	endif

	return 0 ; plain
EndFunction

; ### Punishment reasons

Int[] _next_punishment_reason_slot
Int[] Property next_punishment_reason_slot
	Int[] Function Get()	
		if !_next_punishment_reason_slot
			_next_punishment_reason_slot = new Int[8] ; limited to 8, that's a good number
			next_punishment_reason_nb = 0
		endif
		return _next_punishment_reason_slot
	EndFunction
EndProperty

bool Property whipping_active = false Auto Hidden

; Number of registered punishing reasons
int next_punishment_reason_nb = 0
; Whipping reason
bool Property whipping_by_trainer = false Auto Hidden
bool Property punishing_trainee_or_trainer = false Auto Hidden
int Property whipping_pain_damage = 0 Auto Hidden
int Property cane_pain_damage = 0 Auto Hidden
int Property slap_pain_damage = 0 Auto Hidden
int Property whip_pain_damage = 0 Auto Hidden
int Property whipping_reason = 0 Auto Hidden
string Property whipping_type Auto Hidden
string Property whipping_reason_name = "no reason" Auto Hidden
; Current physical or sexual punishment reason, other than whipping
string Property current_punishment_type Auto Hidden
int Property current_punishment_reason = 0 Auto Hidden
string Property current_punishment_reason_name = "no reason" Auto Hidden
; Last punishment reason, all abuse types
int last_punishment_reason = 0
int __last_toldoff_reason = 0
int Property last_toldoff_reason Hidden
	int Function get()
		return __last_toldoff_reason
	EndFunction
	Function set(int value)
		if __last_toldoff_reason == value
			return
		endif
		__last_toldoff_reason = value
		if __last_toldoff_reason == 25
			RegisterForUpdateChanceRunAway()
			RegisterForUpdateChanceRunAwayGang()
		endif
	EndFunction
EndProperty

string last_punishment_reason_name    = "no reason"
; Warned against reason
int __warn_punishment_reason = 0
int Property warn_punishment_reason Hidden
	int Function get()
		return __warn_punishment_reason
	EndFunction
	Function set(int value) 
		if __warn_punishment_reason == value
			return
		endif
		__warn_punishment_reason = value
		if __warn_punishment_reason == 25
			RegisterForUpdateChanceRunAway()
			RegisterForUpdateChanceRunAwayGang()
		endif
	EndFunction
EndProperty
string warn_punishment_reason_name    = "no reason"
string last_toldoff_reason_name    = "no reason"
; Last abuse type
string abuse_type = "physical"
; Special flag for crying slaves
bool force_crying_as_punishment_reason = false
int timer_warned = 0
int reason_warned = -1

int Function WillObeyBecauseWarned(int reason, float modifier = 1.0)
	if reason == reason_warned && timer_warned > 0
		return 1 ; will obey
	endif
	if !WasWarned(reason)
		return -1 ; not warned
	endif
	if RandomFloat() < __MOD_Discipline*modifier
		timer_warned = 10
		reason_warned = reason
		return 1 ; will obey
	endif
	return 0 ; will not obey
EndFunction

bool Function WillObeyBecausePunished(int reason, float modifier = 1.0)
	if !WasPunishedFor(reason)
		return false
	endif
	Float base_chance = (((submission + 10.0) * 1.6) / 110.0)*MOD_Discipline
	float psh_chance  = (1.0+(__chance_recently_punished * 0.8))
	float chance = modifier * psh_chance * base_chance * ChanceRangeHigh(resignation, 0.0, 100.0)
	;LogTrace("WillObeyBecausePunished chance="+chance+" base="+base_chance+" psh="+psh_chance+" sub="+submission+" discipline="+MOD_Discipline)
	if RandomFloat() < chance
		;LogTrace("WillObeyBecausePunished OK")
		return true
	endif
	;LogTrace("WillObeyBecausePunished FAIL")
	return false
EndFunction

bool Function WillObeyBecauseAbuse(int reason, float modifier = 1.0)
	if WasPunishedFor(reason)
		return true
	endif
	Float base_chance = (((submission + 10.0) * 1.6) / 110.0)*MOD_Discipline
	float psh_chance  = (1.0+(__chance_recently_punished * 0.8))
	float chance = modifier * psh_chance * base_chance * ChanceRangeHigh(resignation, 0.0, 100.0)
	;LogTrace("WillObeyBecausePunished chance="+chance+" base="+base_chance+" psh="+psh_chance+" sub="+submission+" discipline="+MOD_Discipline)
	if RandomFloat() < chance
		;LogTrace("WillObeyBecausePunished OK")
		return true
	endif
	;LogTrace("WillObeyBecausePunished FAIL")
	return false
EndFunction

bool Function WasWarned(int reason)
	if __last_toldoff_reason > 0 && __last_toldoff_reason == reason
		return true
	endif
	if __warn_punishment_reason <= 0
		return false
	endif
	if __warn_punishment_reason == reason
		return true
	endif
	if (__warn_punishment_reason==2 && reason==22) ; "covering self" && "refusing to strip"
		return true
	endif
	if (__warn_punishment_reason==19 && reason==20) ; "didnt masturbate" && "refusing to masturbate"
		return true
	endif
	if (__warn_punishment_reason==7 && reason==6) ; "struggling" && "yelling"
		return true
	endif
	if (__warn_punishment_reason==12 && reason==11) ; "being angry" && "being jealous"
		return true
	endif
	if (__warn_punishment_reason==13) ; "being disrespectful"
		if reason==18 ; "didnt obey"
			return true
		elseif reason==17 ; "didnt listen"
			return true
		elseif reason==16 ; "didnt wait"
			return true
		elseif reason==5 ; "talking"
			return true
		elseif reason==10 ; "being a bad maid" / "being a bad servant"
			return true
		elseif reason==30 ; "being a bad worker"
			return true
		endif
	endif
	return false
EndFunction

bool Function WasPunishedFor(int reason)
	if last_punishment_reason != reason
		return false
	endif
	return true
EndFunction

Function ClearLastPunishmentReason()
	if whipping_reason <= 0 && !whipping_active && GetNextPunishmentReasonByIndex() <= 0
		last_punishment_reason = 0
		last_punishment_reason_name = "no reason"
	endif
EndFunction

Function AddNextPunishmentReason(int the_reason)
	;LogTrace("AddNextPunishmentReason() "+name+" n="+next_punishment_reason_nb+" "+the_reason+" "+DOM01.GetJSONPunishmentReasonNameByIndex(the_reason,actorSex))	
	int i = 0
	int n = next_punishment_reason_slot.length
	while i < n
		int reason = next_punishment_reason_slot[i]
		if reason <= 0
			AddNextPunishmentReasonInSlot(i,the_reason)
			return
		endif
		if reason == the_reason
			return ; already registered
		endif
		i += 1
	endwhile
	; Reason was not registered because array was full,
	; if minor reason skip
	if IsSmallReason(the_reason)
		return
	endif
	; if major reason try again
	i = 0
	while i < n
		int reason = next_punishment_reason_slot[i]
		if IsSmallReason(reason)
			AddNextPunishmentReasonInSlot(i,the_reason)
			return
		endif
		if reason == the_reason
			return ; already registered
		endif
		i += 1
	endwhile
	; Still not registered need to remove the oldest reason
	i = 0
	int m = n-(1)
	while i < m
		int reason = next_punishment_reason_slot[i]
		if !IsVeryImportantReason(reason)
			AddNextPunishmentReasonInSlot(i,next_punishment_reason_slot[i+1])
			RemoveNextPunishmentReasonInSlot(i+1)
		endif
		i += 1
	endwhile
	AddNextPunishmentReasonInSlot(m,the_reason)
EndFunction

Function SetPunishmentReasonsFromFactions()
	int reason
	if akRef.IsInFaction(DOM01.DOMPunishmentReason0)
		reason = akRef.GetFactionRank(DOM01.DOMPunishmentReason0)
		if reason > 0
			AddNextPunishmentReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPunishmentReason1)
		reason = akRef.GetFactionRank(DOM01.DOMPunishmentReason1)
		if reason > 0
			AddNextPunishmentReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPunishmentReason2)
		reason = akRef.GetFactionRank(DOM01.DOMPunishmentReason2)
		if reason > 0
			AddNextPunishmentReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPunishmentReason3)
		reason = akRef.GetFactionRank(DOM01.DOMPunishmentReason3)
		if reason > 0
			AddNextPunishmentReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPunishmentReason4)
		reason = akRef.GetFactionRank(DOM01.DOMPunishmentReason4)
		if reason > 0
			AddNextPunishmentReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPunishmentReason5)
		reason = akRef.GetFactionRank(DOM01.DOMPunishmentReason5)
		if reason > 0
			AddNextPunishmentReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPunishmentReason6)
		reason = akRef.GetFactionRank(DOM01.DOMPunishmentReason6)
		if reason > 0
			AddNextPunishmentReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPunishmentReason7)
		reason = akRef.GetFactionRank(DOM01.DOMPunishmentReason7)
		if reason > 0
			AddNextPunishmentReason(reason)
		endif
	endif
EndFunction

Function AddNextPunishmentReasonInSlot(int slot, int reason)
	if reason <= 0
		return
	endif
	if next_punishment_reason_slot[slot] <= 0
		next_punishment_reason_nb += 1
	endif
	next_punishment_reason_slot[slot] = reason
	string the_reason = DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex)
	if slot == 0
		akRef.SetFactionRank(DOM01.DOMPunishmentReason0,reason)
		;LogTrace("AddNextPunishmentReasonInSlot() "+name+" reason0="+reason+" "+the_reason)			
	elseif slot == 1
		akRef.SetFactionRank(DOM01.DOMPunishmentReason1,reason)
		;LogTrace("AddNextPunishmentReasonInSlot() "+name+" reason1="+reason+" "+the_reason)				
	elseif slot == 2
		akRef.SetFactionRank(DOM01.DOMPunishmentReason2,reason)
		;LogTrace("AddNextPunishmentReasonInSlot() "+name+" reason2="+reason+" "+the_reason)				
	elseif slot == 3
		akRef.SetFactionRank(DOM01.DOMPunishmentReason3,reason)
		;LogTrace("AddNextPunishmentReasonInSlot() "+name+" reason3="+reason+" "+the_reason)				
	elseif slot == 4
		akRef.SetFactionRank(DOM01.DOMPunishmentReason4,reason)
		;LogTrace("AddNextPunishmentReasonInSlot() "+name+" reason4="+reason+" "+the_reason)				
	elseif slot == 5
		akRef.SetFactionRank(DOM01.DOMPunishmentReason5,reason)
		;LogTrace("AddNextPunishmentReasonInSlot() "+name+" reason5="+reason+" "+the_reason)				
	elseif slot == 6
		akRef.SetFactionRank(DOM01.DOMPunishmentReason6,reason)
		;LogTrace("AddNextPunishmentReasonInSlot() "+name+" reason6="+reason+" "+the_reason)				
	elseif slot == 7
		akRef.SetFactionRank(DOM01.DOMPunishmentReason7,reason)
		;LogTrace("AddNextPunishmentReasonInSlot() "+name+" reason7="+reason+" "+the_reason)				
	endif
EndFunction

Function RemoveNextPunishmentReasonInSlot(int slot)
	if next_punishment_reason_slot[slot] <= 0
		return
	endif
	next_punishment_reason_nb -= 1
	next_punishment_reason_slot[slot] = -1
	if slot == 0
		akRef.RemoveFromFaction(DOM01.DOMPunishmentReason0)
		;LogTrace("RemoveNextPunishmentReasonInSlot() "+name+" reason0=none")			
	elseif slot == 1
		akRef.RemoveFromFaction(DOM01.DOMPunishmentReason1)
		;LogTrace("RemoveNextPunishmentReasonInSlot() "+name+" reason1=none")			
	elseif slot == 2
		akRef.RemoveFromFaction(DOM01.DOMPunishmentReason2)
		;LogTrace("RemoveNextPunishmentReasonInSlot() "+name+" reason2=none")			
	elseif slot == 3
		akRef.RemoveFromFaction(DOM01.DOMPunishmentReason3)
		;LogTrace("RemoveNextPunishmentReasonInSlot() "+name+" reason3=none")			
	elseif slot == 4
		akRef.RemoveFromFaction(DOM01.DOMPunishmentReason4)
		;LogTrace("RemoveNextPunishmentReasonInSlot() "+name+" reason4=none")			
	elseif slot == 5
		akRef.RemoveFromFaction(DOM01.DOMPunishmentReason5)
		;LogTrace("RemoveNextPunishmentReasonInSlot() "+name+" reason5=none")			
	elseif slot == 6
		akRef.RemoveFromFaction(DOM01.DOMPunishmentReason6)
		;LogTrace("RemoveNextPunishmentReasonInSlot() "+name+" reason6=none")			
	elseif slot == 7
		akRef.RemoveFromFaction(DOM01.DOMPunishmentReason7)
		;LogTrace("RemoveNextPunishmentReasonInSlot() "+name+" reason7=none")			
	endif
EndFunction

Int Function GetNumberOfNextPunishmentReasons()
	if actor_alias.is_running_away
		AddNextPunishmentReason(25) ; running away
	endif
	int i = 0
	int n = next_punishment_reason_slot.length
	while i < n
		int reason = next_punishment_reason_slot[i]
		if reason <= 0
			;LogTrace("GetNumberOfNextPunishmentReasons() "+name+" = "+i)		
			return i
		endif
		i += 1
	endwhile
	;LogTrace("GetNumberOfNextPunishmentReasons() "+name+" = 0")		
	return i
EndFunction

String Function GetNextPunishmentReason(int islot)
	int ireason = next_punishment_reason_slot[islot]
	return DOM01.GetJSONPunishmentReasonNameByIndex(ireason,actorSex)
EndFunction

int Function GetAnyPunishmentReason(string the_reason)
	if the_reason == ""
		return GetNextPunishmentReasonByIndex()
	endif
	
	int ireason = DOM01.GetJSONPunishmentReasonIndexByName(the_reason)
	if ireason <= 0
		if IsDevoted()
			return 9 ; "being a bad slave"
		endif
		return GetNextPunishmentReasonByIndex()
	endif
	return ireason
EndFunction

int Function GetNextPunishmentReasonByIndex()
	if force_crying_as_punishment_reason
		return 4 ; "crying"
	endif
	
	if next_punishment_reason_nb > 0
		; Find a very important reason
		int reason = GetVeryImportantNextPunishmentReason()
		if reason > 0
			return reason
		endif

		; Find a major reason
		reason = GetMajorNextPunishmentReason()
		if reason > 0
			return reason
		endif
	endif

	; Find another major reason in current behaviour
	if actor_alias != None
		if actor_alias.is_running_away
			return 25 ; "running away"
		elseif !actor_alias.is_naked && should_be_naked
			return 2 ; covering self
		elseif actor_alias.IsStruggling()
			return 7 ; "struggling"
		endif
	elseif should_be_respectful && !was_respectful
		return 13 ; "being disrespectful"
	elseif should_walk_on_four && !is_walking_on_four
		return 32 ; "not walking on four"
	elseif should_be_silent && !was_silent
		return 5 ; "talking"
	elseif IsAngry()
		return 12 ; "being angry"
	endif
	
	if next_punishment_reason_nb > 0
		; Find any reason
		int reason = GetAnyNextPunishmentReason()
		if reason > 0
			return reason
		endif
	endif
	
	; Find any reason in current behaviour
	if DOM01.cryingPunishmentToggle && IsCrying()
		return 4 ; "crying"
	elseif IsAngry()
		return 12 ; "being angry"
	elseif actor_alias != None
		if actor_alias.is_behaviour_pose && pose_training < 100.0
			return 8 ; "posture correction"
		elseif actor_alias.IsTied() && IsDevoted() && pose_training < 100.0
			return 8 ; "posture correction"
		endif
	endif
	
	; no reason found
	return 0
EndFunction

Int Function GetVeryImportantNextPunishmentReason()
	int i = 0
	int n = next_punishment_reason_slot.length
	while i < n
		int reason = next_punishment_reason_slot[i]
		if reason <= 0
			return -1
		elseif IsVeryImportantReason(reason)
			return reason
		endif
		i += 1
	endwhile
	return -1
EndFunction

Int Function GetMajorNextPunishmentReason()
	int i = 0
	int n = next_punishment_reason_slot.length
	while i < n
		int reason = next_punishment_reason_slot[i]
		if reason <= 0
			return -1
		elseif !IsSmallReason(reason)
			return reason
		endif
		i += 1
	endwhile
	return -1
EndFunction

Int Function GetAnyNextPunishmentReason()
	int i = 0
	int n = next_punishment_reason_slot.length
	while i < n
		int reason = next_punishment_reason_slot[i]
		if reason <= 0
			return -1
		else
			return reason
		endif
		i += 1
	endwhile
	return -1
EndFunction

String Function GetNextPunishmentReasons()
	;LogTrace("GetNextPunishmentReasons() "+name)		
	String results = ""
	
	int i = 0
	int n = next_punishment_reason_slot.length
	while i < n
		int reason = next_punishment_reason_slot[i]
		;LogTrace("GetNextPunishmentReasons() "+name+" reason "+i+" = "+reason)		
		if reason > 0
			string reason_name = DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex)
			results = AddStringsWithComma(results,reason_name)
		endif
		i += 1
	endwhile

	; Find other reasons in current behaviour
	if force_crying_as_punishment_reason && !(stringUtil.find(results,"crying")>=0)
		results = AddStringsWithComma(results,"crying")
	endif

	if actor_alias.is_running_away && !(stringUtil.find(results,"running away")>=0)
		results = AddStringsWithComma(results,"running away")
	elseif should_be_respectful && !was_respectful && !(stringUtil.find(results,"being disrespectful")>=0)
		results = AddStringsWithComma(results,"being disrespectful")
	elseif should_be_silent && !was_silent && !(stringUtil.find(results,"talking")>=0)
		results = AddStringsWithComma(results,"talking")
	elseif actor_alias.IsStruggling() && !(stringUtil.find(results,"struggling")>=0)
		results = AddStringsWithComma(results,"struggling")
	elseif IsAngry() && !(stringUtil.find(results,"being angry")>=0)
		results = AddStringsWithComma(results,"being angry")
	elseif actor_alias.is_behaviour_pose && pose_training < 100.0 && !(stringUtil.find(results,"posture correction")>=0)
		results = AddStringsWithComma(results,"posture correction")
	elseif actor_alias.IsTied() && IsDevoted() && pose_training < 100.0 && !(stringUtil.find(results,"posture correction")>=0)
		results = AddStringsWithComma(results,"posture correction")
	endif
	
	if results == ""
		return "no reason"
	endif
	return results
EndFunction

Function SetNextPunishmentReasonSilent(int reason)
	if reason == 4 && !DOM01.cryingPunishmentToggle ; "crying"
		return
	endif
	if HasNextPunishmentReason(reason)
		;LogTrace("SetNextPunishmentReasonSilent() NO reason="+reason+" already registered "+DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex))			
		return
	endif

	;LogTrace("SetNextPunishmentReasonSilent() YES reason="+reason+" "+DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex))			
	AddNextPunishmentReason(reason)
EndFunction

Function SetNextPunishmentReasonOnceMessage(int reason, String the_message)
	if reason == 4 && !DOM01.cryingPunishmentToggle ; "crying"
		return
	endif
	if HasNextPunishmentReason(reason)
		;LogTrace("SetNextPunishmentReasonOnceMessage() NO reason="+reason+" already registered "+DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex))			
		return
	endif
	
	;LogTrace("SetNextPunishmentReasonOnceMessage() YES reason="+reason+" "+DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex))			
	AddNextPunishmentReason(reason)
	if the_message != ""
		SendNotificationOrder(name+" "+the_message)
	endif
EndFunction

Function SetNextPunishmentReasonForceMessage(int reason, String the_message)
	if reason == 4 && !DOM01.cryingPunishmentToggle ; "crying"
		return
	endif
	if HasNextPunishmentReason(reason)
		;LogTrace("SetNextPunishmentReasonForceMessage() NO reason="+reason+" already registered "+DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex))			
		SendNotificationOrder(name+" "+the_message)
		return
	endif
	
	;LogTrace("SetNextPunishmentReasonForceMessage() YES reason="+reason+" "+DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex))			
	AddNextPunishmentReason(reason)
	if the_message != ""
		SendNotificationOrder(name+" "+the_message)
	endif
EndFunction

bool Function IsPunishingFor(int ireason)
	if whipping_reason == ireason
		return true
	endif
	if current_punishment_reason == ireason
		return true
	endif
	return false
EndFunction

bool Function HasNextPunishmentReason(int the_reason)
	if next_punishment_reason_nb <= 0
		return false
	endif

	int i = 0
	int n = next_punishment_reason_slot.length
	while i < n
		int reason = next_punishment_reason_slot[i]
		if reason <= 0
			return false
		endif
		if reason == the_reason
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction


bool Property correct_cover_self = true Auto Hidden

Function RemoveNextPunishmentReason(int old_reason)
	;LogTrace("RemoveNextPunishmentReason() "+name+" n="+next_punishment_reason_nb+" "+old_reason)			
	if next_punishment_reason_nb <= 0
		return
	endif
	if !correct_cover_self && old_reason == 2 ; "covering self"
		correct_cover_self = true
		return
	endif
	int i = 0
	int n = next_punishment_reason_slot.length
	while i < n
		int reason = next_punishment_reason_slot[i]
		if reason <= 0
			return
		endif
		if reason == old_reason
			RemoveNextPunishmentReasonInSlot(i)
			if i == n-(1) ; was last stored reason
				return
			endif
			int j = i
			int m = n-(1)
			while j < m
				AddNextPunishmentReasonInSlot(j,next_punishment_reason_slot[j+1])
				RemoveNextPunishmentReasonInSlot(j+1)
				j += 1
			endwhile
			return
		endif
		i += 1
	endwhile
EndFunction

string Function GetLastPunishmentReasonString()
	return last_punishment_reason_name
EndFunction

string Function GetLastToldOffReasonString()
	return last_toldoff_reason_name
EndFunction

string Function GetWarnPunishmentReasonString()
	if warn_punishment_reason_name == "" || warn_punishment_reason_name == "no reason"
		return last_toldoff_reason_name
	endif
	return warn_punishment_reason_name
EndFunction

; ### Praise reasons

Int[] _next_praise_reason_slot
Int[] Property next_praise_reason_slot
	Int[] Function Get()	
		if !_next_praise_reason_slot
			_next_praise_reason_slot = new Int[8] ; limited to 8, that's a good number
			 next_praise_reason_nb = 0
		endif
		return _next_praise_reason_slot
	EndFunction
EndProperty
int next_praise_reason_nb = 0
int last_praise_reason = 0
string last_praise_reason_name = "no reason"

Function AddNextPraiseReason(int the_reason)
	;LogTrace("AddNextPraiseReason() "+name+" n="+next_praise_reason_nb+" "+the_reason)			
	int i = 0
	int n = next_praise_reason_slot.length
	while i < n
		int reason = next_praise_reason_slot[i]
		if reason <= 0
			AddNextPraiseReasonInSlot(i,the_reason)
			return
		endif
		if reason == the_reason
			return ; already registered
		endif
		i += 1
	endwhile
	; Reason was not registered because array was full,
	; if minor reason skip
	if IsSmallReason(the_reason)
		return
	endif
	; if major reason try again
	i = 0
	while i < n
		int reason = next_praise_reason_slot[i]
		if IsSmallReason(reason)
			AddNextPraiseReasonInSlot(i,the_reason)
			return
		endif
		if reason == the_reason
			return ; already registered
		endif
		i += 1
	endwhile
	; Still not registered need to remove the oldest reason
	i = 0
	int m = n-(1)
	while i < m
		int reason = next_praise_reason_slot[i]
		if !IsVeryImportantReason(reason)
			AddNextPraiseReasonInSlot(i,next_praise_reason_slot[i+1])
			RemoveNextPraiseReasonInSlot(i+1)
		endif
		i += 1
	endwhile
	AddNextPraiseReasonInSlot(m,the_reason)
EndFunction

Function SetPraiseReasonsFromFactions()
	int reason
	if akRef.IsInFaction(DOM01.DOMPraiseReason0)
		reason = akRef.GetFactionRank(DOM01.DOMPraiseReason0)
		if reason > 0
			AddNextPraiseReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPraiseReason1)
		reason = akRef.GetFactionRank(DOM01.DOMPraiseReason1)
		if reason > 0
			AddNextPraiseReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPraiseReason2)
		reason = akRef.GetFactionRank(DOM01.DOMPraiseReason2)
		if reason > 0
			AddNextPraiseReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPraiseReason3)
		reason = akRef.GetFactionRank(DOM01.DOMPraiseReason3)
		if reason > 0
			AddNextPraiseReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPraiseReason4)
		reason = akRef.GetFactionRank(DOM01.DOMPraiseReason4)
		if reason > 0
			AddNextPraiseReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPraiseReason5)
		reason = akRef.GetFactionRank(DOM01.DOMPraiseReason5)
		if reason > 0
			AddNextPraiseReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPraiseReason6)
		reason = akRef.GetFactionRank(DOM01.DOMPraiseReason6)
		if reason > 0
			AddNextPraiseReason(reason)
		endif
	endif
	if akRef.IsInFaction(DOM01.DOMPraiseReason7)
		reason = akRef.GetFactionRank(DOM01.DOMPraiseReason7)
		if reason > 0
			AddNextPraiseReason(reason)
		endif
	endif
EndFunction

Function AddNextPraiseReasonInSlot(int slot, int reason)
	if reason <= 0
		return
	endif
	if next_praise_reason_slot[slot] <= 0
		next_praise_reason_nb += 1
	endif
	next_praise_reason_slot[slot] = reason
	if slot == 0
		akRef.SetFactionRank(DOM01.DOMPraiseReason0,reason)
		;LogTrace("AddNextPraiseReasonInSlot() "+name+" reason0="+reason)			
	elseif slot == 1
		akRef.SetFactionRank(DOM01.DOMPraiseReason1,reason)
		;LogTrace("AddNextPraiseReasonInSlot() "+name+" reason1="+reason)			
	elseif slot == 2
		akRef.SetFactionRank(DOM01.DOMPraiseReason2,reason)
		;LogTrace("AddNextPraiseReasonInSlot() "+name+" reason2="+reason)			
	elseif slot == 3
		akRef.SetFactionRank(DOM01.DOMPraiseReason3,reason)
		;LogTrace("AddNextPraiseReasonInSlot() "+name+" reason3="+reason)			
	elseif slot == 4
		akRef.SetFactionRank(DOM01.DOMPraiseReason4,reason)
		;LogTrace("AddNextPraiseReasonInSlot() "+name+" reason4="+reason)			
	elseif slot == 5
		akRef.SetFactionRank(DOM01.DOMPraiseReason5,reason)
		;LogTrace("AddNextPraiseReasonInSlot() "+name+" reason5="+reason)			
	elseif slot == 6
		akRef.SetFactionRank(DOM01.DOMPraiseReason6,reason)
		;LogTrace("AddNextPraiseReasonInSlot() "+name+" reason6="+reason)			
	elseif slot == 7
		akRef.SetFactionRank(DOM01.DOMPraiseReason7,reason)
		;LogTrace("AddNextPraiseReasonInSlot() "+name+" reason7="+reason)			
	endif
EndFunction

Function RemoveNextPraiseReasonInSlot(int slot)
	;LogTrace("RemoveNextPraiseReasonInSlot() i="+slot+" reason="+next_praise_reason_slot[slot])
	if next_praise_reason_slot[slot] <= 0
		return
	endif
	next_praise_reason_nb -= 1
	next_praise_reason_slot[slot] = -1
	if slot == 0
		akRef.RemoveFromFaction(DOM01.DOMPraiseReason0)
		;LogTrace("RemoveNextPraiseReasonInSlot() "+name+" reason0=none")			
	elseif slot == 1
		akRef.RemoveFromFaction(DOM01.DOMPraiseReason1)
		;LogTrace("RemoveNextPraiseReasonInSlot() "+name+" reason1=none")			
	elseif slot == 2
		akRef.RemoveFromFaction(DOM01.DOMPraiseReason2)
		;LogTrace("RemoveNextPraiseReasonInSlot() "+name+" reason2=none")			
	elseif slot == 3
		akRef.RemoveFromFaction(DOM01.DOMPraiseReason3)
		;LogTrace("RemoveNextPraiseReasonInSlot() "+name+" reason3=none")			
	elseif slot == 4
		akRef.RemoveFromFaction(DOM01.DOMPraiseReason4)
		;LogTrace("RemoveNextPraiseReasonInSlot() "+name+" reason4=none")			
	elseif slot == 5
		akRef.RemoveFromFaction(DOM01.DOMPraiseReason5)
		;LogTrace("RemoveNextPraiseReasonInSlot() "+name+" reason5=none")			
	elseif slot == 6
		akRef.RemoveFromFaction(DOM01.DOMPraiseReason6)
		;LogTrace("RemoveNextPraiseReasonInSlot() "+name+" reason6=none")			
	elseif slot == 7
		akRef.RemoveFromFaction(DOM01.DOMPraiseReason7)
		;LogTrace("RemoveNextPraiseReasonInSlot() "+name+" reason7=none")			
	endif
EndFunction

Int Function GetNumberOfNextPraiseReasons()
	int i = 0
	int n = next_praise_reason_slot.length
	while i < n
		int reason = next_praise_reason_slot[i]
		if reason <= 0
			;LogTrace("GetNumberOfNextPraiseReasons() "+name+" = "+i)		
			return i
		endif
		i += 1
	endwhile
	;LogTrace("GetNumberOfNextPraiseReasons() "+name+" = 0 ")		
	return i
EndFunction

String Function GetNextPraiseReason(int islot)
	int ireason = next_praise_reason_slot[islot]
	return DOM01.GetJSONPraisingReasonNameByIndex(ireason,actorSex)
EndFunction

Function SetNextPraiseReasonSilent(int reason)
	if reason == 4 && !DOM01.cryingPraiseToggle ; "crying"
		return
	endif
	if HasNextPraiseReason(reason)
		;LogTrace("SetNextPraiseReasonSilent() NO reason="+reason+" already registered "+DOM01.GetJSONPraisingReasonNameByIndex(reason,actorSex))			
		return
	endif

	;LogTrace("SetNextPraiseReasonSilent() YES reason="+reason+" "+DOM01.GetJSONPraisingReasonNameByIndex(reason,actorSex))			
	AddNextPraiseReason(reason)
EndFunction

Function SetNextPraiseReasonOnceMessage(int reason, String the_message)
	if reason == 4 && !DOM01.cryingPunishmentToggle ; "crying"
		return
	endif
	if HasNextPraiseReason(reason)
		;LogTrace("SetNextPraiseReasonOnceMessage() NO reason="+reason+" already registered "+DOM01.GetJSONPraisingReasonNameByIndex(reason,actorSex))			
		return
	endif
	
	;LogTrace("SetNextPraiseReasonOnceMessage() YES reason="+reason+" "+DOM01.GetJSONPraisingReasonNameByIndex(reason,actorSex))			
	AddNextPraiseReason(reason)
	if the_message != ""
		SendNotificationOrder(name+" "+the_message)
	endif
EndFunction

int Function GetNextPraiseReasonByIndex()
	if next_praise_reason_nb > 0
		; Find a very important reason
		int reason = GetVeryImportantNextPraiseReason()
		if reason > 0
			return reason
		endif

		; Find a major reason
		reason = GetMajorNextPraiseReason()
		if reason > 0
			return reason
		endif
	
		; Find any reason
		reason = GetAnyNextPraiseReason()
		if reason > 0
			return reason
		endif
	endif
	
	; Find any reason in current behaviour
	if DOM01.cryingPraiseToggle && IsCrying()
		return 4 ; "crying"
	endif
	
	; no reason found
	return 0
EndFunction

Int Function GetVeryImportantNextPraiseReason()
	int i = 0
	int n = next_praise_reason_slot.length
	while i < n
		int reason = next_praise_reason_slot[i]
		if reason <= 0
			return -1
		elseif IsVeryImportantReason(reason)
			return reason
		endif
		i += 1
	endwhile
	return -1
EndFunction

Int Function GetMajorNextPraiseReason()
	int i = 0
	int n = next_praise_reason_slot.length
	while i < n
		int reason = next_praise_reason_slot[i]
		if reason <= 0
			return -1
		elseif !IsSmallReason(reason)
			return reason
		endif
		i += 1
	endwhile
	return -1
EndFunction

Int Function GetAnyNextPraiseReason()
	int i = 0
	int n = next_praise_reason_slot.length
	while i < n
		int reason = next_praise_reason_slot[i]
		if reason <= 0
			return -1
		else
			return reason
		endif
		i += 1
	endwhile
	return -1
EndFunction

string Function GetNextPraiseReasons()
	;LogTrace("GetNextPraiseReasons() "+name)		
	String results = ""
	
	int i = 0
	int n = next_praise_reason_slot.length
	while i < n
		int reason = next_praise_reason_slot[i]
		;LogTrace("GetNextPraiseReasons() "+name+" reason "+i+" = "+reason)		
		if reason > 0
			string reason_name = DOM01.GetJSONPraisingReasonNameByIndex(reason,actorSex)
			results = AddStringsWithComma(results,reason_name)
		endif
		i += 1
	endwhile
	
	if results == ""
		return "no reason"
	endif
	return results
EndFunction

bool Function HasNextPraiseReason(int the_reason)
	if next_praise_reason_nb <= 0
		return false
	endif

	int i = 0
	int n = next_praise_reason_slot.length
	while i < n
		int reason = next_praise_reason_slot[i]
		if reason <= 0
			return false
		endif
		if reason == the_reason
			return true
		endif
		i += 1
	endwhile
	return false
EndFunction

Function RemoveNextPraiseReason(int old_reason)
	;LogTrace("RemoveNextPraiseReason() n="+next_praise_reason_nb+" "+old_reason)			
	if next_praise_reason_nb <= 0
		return
	endif
	int i = 0
	int n = next_praise_reason_slot.length
	while i < n
		int reason = next_praise_reason_slot[i]
		;LogTrace("RemoveNextPraiseReason() i="+i+" "+reason)			
		if reason <= 0
			return
		endif
		if reason == old_reason || (reason == 20 && old_reason == 30) || (reason == 30 && old_reason == 20) ; 20/30 is to be removed later
			;LogTrace("RemoveNextPraiseReason() found i="+i+" "+reason+" "+old_reason)			
			RemoveNextPraiseReasonInSlot(i)
			if i == n-(1) ; was last stored reason
				return
			endif
			int j = i
			int m = n-(1)
			while j < m
				AddNextPraiseReasonInSlot(j,next_praise_reason_slot[j+1])
				RemoveNextPraiseReasonInSlot(j+1)
				j += 1
			endwhile
			return
		endif
		i += 1
	endwhile
EndFunction

; ### Is feeling

bool Function StartGuilt()
	bool broken = false
	if IsAngry()
		return false
	endif
	if IsBrokenToObey() || IsObedient()
		broken = true
	elseif RandomFloat() < MOD_SumAll || RandomFloat() < MOD_Gentleness
		broken = true
	endif
	
	if !broken
		MakeAngryFor(5.0)
		return false
	endif
	
	ChooseMoodSpontaneousOnTick(0.1)
	ticks_since_last_punished = 0
	time_last_abused = GetCurrentGameTime()
	time_last_resilience = time_last_abused
	return true
EndFunction

bool Function IsComforted()
	bool broken = false
	if IsBrokenToObey() || IsObedient()
		broken = true
	elseif RandomFloat() < MOD_SumAll || RandomFloat() < MOD_Prudent
		broken = true
	endif
	
	if !broken
		SendNotificationOrder(name+" does not want to listen to you")
		MakeAngryFor(5.0)
		return false
	endif
	if promiseOath == "to be gentle" && IsInLove()
		promise_kept = 1
	endif
	
	if IsShocked() ; Actor is in shock, try to make him/her feel better
		if RecoverFromShockByComfort()
			number_of_comfort += 1
		endif
	elseif IsCrying() ; Slave is sad, try to make him/her feel better
		if RecoverFromSadByComfort()
			number_of_comfort += 1
		endif
	else
		ChooseMoodSpontaneousOnTick(0.1)
	endif
	IncreaseArousal(5.0,MOD_Consideration)

	; forget about last punishments
	ticks_since_last_punished += 10
	return true
EndFunction

bool Function IsAVirgin()
	if (actorSex%2) == ((DOM01.DOMPlayerAlias.GetPlayerSex())%2)
		if virgin_status_same == 0
			return true
		endif
		return false
	endif

	if virgin_status_vaginal == 0
		return true
	endif
	return false
EndFunction

; ### Interactions, Praise, Punishments & Sex

Function StartPricing(Actor akAbuser)
	abuse_type = "physical"
	int value = DOM01.DOMGenerator.GetActorPrice(akRef)
	SendNotificationOrder("Checking the value of "+GetMoodNameThirdPerson()+name+". Value: "+value)
	;LogTrace("Checking the value of "+GetMoodNameThirdPerson()+name+". Value: "+value)
	float mod = DOM01.GetSlaverModifier(akAbuser)
	TrainAnger(DOM01.train_speed_tell*0.1*mod)
	IncreaseArousal(5.0,MOD_Naivety)
	IsArousedAfterShame(MOD_Naivety)
	MakeAshamedFor(DOM01.train_speed_tell*0.05*mod)
	CheckAndRegisterKink(70,0.5) ; "being put on display"
	if akAbuser == PlayerRef ; player
		DOM01.DOM04.NotifyEndPricing(actor_alias,value,true)
		actor_alias.SendExternalEventSFB("PriceInspection",value as float,true)
	endif
	ticks_since_last_punished = 0
	time_last_abused = GetCurrentGameTime()
	time_last_resilience = time_last_abused
	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillSlaver(0.5)
		akAggressorMind.SetNextPraiseReasonSilent(45) ; "being a good slaver"
		akAggressorMind.CheckAndRegisterKink(107,1.0) ; "managing slaves"
	else
		DOM01.TrainSkillSlaver(akAbuser,0.5)
	endif
EndFunction

bool Function StartUndressingForced(Actor akAbuser)
	abuse_type = "sexual"
	float mod = DOM01.GetDepraverModifier(akAbuser)
	IncreaseArousal(10.0,MOD_Fearfulness)
	TrainFear(DOM01.train_speed_tell*0.1*mod)
	IsArousedAfterShame(MOD_Naivety)
	MakeAshamedFor(DOM01.train_speed_tell*0.05*mod)	
 	CheckAndRegisterKink(11,2.0) ; "being stripped"
	if akAbuser == PlayerRef
		DOM01.DOM04.NotifyStrip(actor_alias,"rip-off",true)
		actor_alias.SendExternalEventSSB("Undress","rip-off",true)
	endif
	SendNotificationOrder("Ripping "+GetMoodNameThirdPerson()+name+" off of "+actorPossessive+" clothes ")
	ticks_since_last_punished = 0
	time_last_abused = GetCurrentGameTime()
	time_last_resilience = time_last_abused
	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillDepraver(0.5)
		akAggressorMind.SetNextPraiseReasonSilent(50) ; "being a horny slaver"
		akAggressorMind.CheckAndRegisterKink(109,0.5) ; "stripping slaves"
	else
		DOM01.TrainSkillDepraver(akAbuser,0.5)
	endif
	return false ; IsBrokenToObey() || IsObedient()
EndFunction

bool Function StartUndressing(Actor akAbuser)
	abuse_type = "sexual"
	;Check if actor is in the mood
	bool broken = true
	if IsObedient()
		if IsScaredToObey()
			if actor_alias.is_in_city
				if WasPunishedFor(22) || RandomFloat() > MOD_Naivety*2.0 ; "refusing to strip"
					SendNotificationOrder(name+" looks around but is too afraid to say no")	
					IncreaseArousal(20.0,MOD_Naivety)
				else
					SetNextPunishmentReasonForceMessage(22,"refuses to strip in a public place") ; "refusing to strip"
					IncreaseArousal(5.0,MOD_Naivety)
					broken = false
				endif
			else
				SetNextPunishmentReasonOnceMessage(23,"is scared and strips")	
				IncreaseArousal(15.0,MOD_Naivety)
			endif
		else
			if is_slave
				SendNotificationOrder(name+" starts undressing like a good slave")	
			else
				SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and starts undressing")
			endif
			IncreaseArousal(15.0,MOD_Naivety)
		endif
		if broken
			SendNotificationAbuse("Humiliating "+GetMoodNameThirdPerson()+name+" by scaring "+actorObjective+" to strip")
		endif
	elseif WillObeyBecauseWarned(2) > 0 ; "covering self"
		SetNextPunishmentReasonOnceMessage(23,"hesitates but remembers your warning") ; "not stripping well enough"
		IncreaseArousal(20.0,MOD_Naivety)
		SendNotificationAbuse("Humiliating "+GetMoodNameThirdPerson()+name+" by ordering "+actorObjective+" to strip")
	elseif IsWillingToObey()
		SendNotificationOrder(name+" obeys")
		IncreaseArousal(10.0,MOD_Naivety)
		SendNotificationAbuse("Humiliating "+GetMoodNameThirdPerson()+name+" by ordering "+actorObjective+" to strip")
	else
		broken = false
	endif
	
	if !broken
		SetNextPunishmentReasonForceMessage(22,"refuses to strip") ; "refusing to strip"
		should_be_naked = false
	else
		IsArousedAfterShame(MOD_Naivety)
		float mod = DOM01.GetPersuaderModifier(akAbuser)
		MakeAshamedFor(DOM01.train_speed_tell*0.1*mod)
		CheckAndRegisterKink(10,2.0) ; "being forced to strip"
		should_be_naked = true
		time_last_abused = GetCurrentGameTime()
		time_last_resilience = time_last_abused
		DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
		if akAggressorMind != None
			akAggressorMind.TrainSkillPersuader(0.5)
			akAggressorMind.SetNextPraiseReasonSilent(43) ; "being a scary trainer"
			akAggressorMind.CheckAndRegisterKink(109,0.5) ; "stripping slaves"
		else
			DOM01.TrainSkillPersuader(akAbuser,0.5)
		endif
	endif
	if akAbuser == PlayerRef
		DOM01.DOM04.NotifyStrip(actor_alias,"strip",broken)
		actor_alias.SendExternalEventSSB("Undress","strip",broken)
	endif
	return broken
EndFunction

bool Function StartShowering(Actor akAbuser, string wash_type)
	LogTrace("StartShowering")
	abuse_type = "physical"
	;Check if actor is in the mood
	if actor_alias.is_restrained 
		if wash_type == "hose"
			SendNotificationOrder(name+" is restrained and will get hosed")	
			return false
		endif
		SendNotificationOrder(name+" is restrained and can not wash "+actorObjective+"self")	
		return false
	endif
	bool broken = true
	if IsObedient()
		LogTrace("StartShowering is obedient")
		if IsScaredToObey()
			if actor_alias.is_in_city
				if WasPunishedFor(28) || RandomFloat() > MOD_Ingenuity*2.0 ; "refusing to shower"
					SendNotificationOrder(name+" looks around but is too afraid to say no")	
					IncreaseArousal(20.0,MOD_Ingenuity)
				else
					SetNextPunishmentReasonForceMessage(28,"refuses to shower in a public place") ; "refusing to shower"
					broken = false
				endif
			elseif !actor_alias.is_naked
				SetNextPunishmentReasonOnceMessage(23,"is scared and hastily strips to shower")	
				IncreaseArousal(10.0,MOD_Naivety)
			else
				SendNotificationOrder(name+" is scared and proceeds to shower")	
				IncreaseArousal(10.0,MOD_Ingenuity)
			endif
		else
			if is_slave
				SendNotificationOrder(name+" starts undressing like a good slave")	
			else
				SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and starts undressing")
			endif
			IncreaseArousal(20.0,MOD_Ingenuity)
		endif
	elseif WillObeyBecauseWarned(28) > 0 ; "refuses to shower"
		SendNotificationOrder(name+" hesitates but remembers your warning")
		IncreaseArousal(20.0,MOD_Ingenuity)
		;SendNotificationAbuse("Humiliating "+GetMoodNameThirdPerson()+name+" by ordering "+actorObjective+" to shower")
	elseif IsWillingToObey()
		SendNotificationOrder(name+" obeys")
		IncreaseArousal(10.0,MOD_Ingenuity)
		;SendNotificationAbuse("Humiliating "+GetMoodNameThirdPerson()+name+" by ordering "+actorObjective+" to shower")
	else
		LogTrace("StartShowering is NOT BROKEN mood="+mood)
		broken = false
	endif

	if !broken
		if wash_type == "hose"
			SetNextPunishmentReasonForceMessage(28,"refuses to shower but will get hosed") ; "refusing to shower"
			CheckAndRegisterKink(68,2.0) ; "being hosed"
		else
			SetNextPunishmentReasonForceMessage(28,"refuses to shower") ; "refusing to shower"
		endif
		if akAbuser == PlayerRef ; player
			DOM01.DOM04.NotifyShowering(actor_alias,wash_type,false)
			actor_alias.SendExternalEventSSB("WashSelf",wash_type,false)
		endif
	else
		if wash_type == "hose"
			CheckAndRegisterKink(68,2.0) ; "being hosed"
		endif
		CheckAndRegisterKink(69,2.0) ; "being forced to wash"
		IsArousedAfterShame(MOD_Ingenuity)
		MakeAshamedFor(DOM01.train_speed_tell*0.1*DOM01.GetSlaverModifier(akAbuser))
		UndressBeforeShowering()
		time_last_abused = GetCurrentGameTime()
		time_last_resilience = time_last_abused
		DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
		if akAggressorMind != None
			DOM01.DOM04.NotifyShowering(actor_alias,wash_type,true)
			actor_alias.SendExternalEventSSB("WashSelf",wash_type,true)
			akAggressorMind.TrainSkillSlaver(0.5)
			akAggressorMind.SetNextPraiseReasonSilent(45) ; "being a good slaver"
			akAggressorMind.CheckAndRegisterKink(107,1.0) ; "managing slaves"
		else
			DOM01.TrainSkillSlaver(akAbuser,0.5)
		endif
	endif	
	return broken
EndFunction

bool Function StartBathMe(Actor akAbuser, string wash_type)
	LogTrace("StartBathMe")
	abuse_type = "physical"
	;Check if actor is in the mood
	bool broken = true
	if IsObedient()
		if IsScaredToObey()
			if actor_alias.is_in_city
				if WasPunishedFor(33) || RandomFloat() > MOD_Ingenuity*2.0 ; "refusing to give a bath"
					SendNotificationOrder(name+" is too afraid to say no")	
					IncreaseArousal(20.0,MOD_Ingenuity)
				else
					SetNextPunishmentReasonForceMessage(33,"refuses to get naked in a public place") ; "refusing to give a bath"
					broken = false
				endif
			elseif !actor_alias.is_naked
				SetNextPunishmentReasonOnceMessage(23,"is scared and hastily strips to proceed")	
				IncreaseArousal(10.0,MOD_Naivety)
			else
				SendNotificationOrder(name+" is scared and proceeds to give a bath")	
				IncreaseArousal(10.0,MOD_Ingenuity)
			endif
		else
			if is_slave
				SendNotificationOrder(name+" starts undressing to prepare for giving a bath")	
			else
				SendNotificationOrder(name+" wouldn't want to discuss "+DOM01.DOMPlayerAlias.GetPlayerPossessive()+" orders and starts undressing")
			endif
			IncreaseArousal(20.0,MOD_Ingenuity)
		endif
	elseif WillObeyBecauseWarned(2) > 0 ; "covering self"
		SendNotificationOrder(name+" hesitates but remembers your warning")
		IncreaseArousal(20.0,MOD_Ingenuity)
		;SendNotificationAbuse("Humiliating "+GetMoodNameThirdPerson()+name+" by ordering "+actorObjective+" to shower")
	elseif IsWillingToObey()
		SendNotificationOrder(name+" obeys")
		IncreaseArousal(10.0,MOD_Ingenuity)
		;SendNotificationAbuse("Humiliating "+GetMoodNameThirdPerson()+name+" by ordering "+actorObjective+" to shower")
	else
		broken = false
	endif

	if !broken
		SetNextPunishmentReasonForceMessage(33,"refuses to give a bath") ; "refusing to give a bath"
		if akAbuser == PlayerRef ; player
			DOM01.DOM04.NotifyShowering(actor_alias,wash_type,false)
			actor_alias.SendExternalEventSSB("WashMe",wash_type,false)
		endif
	else
		IsArousedAfterShame(MOD_Ingenuity)
		MakeAshamedFor(DOM01.train_speed_tell*0.1*DOM01.GetSlaverModifier(akAbuser))
		UndressBeforeShowering()
		CheckAndRegisterKink(88,2.0) ; "being forced to give a bath"
		time_last_abused = GetCurrentGameTime()
		time_last_resilience = time_last_abused
		SetNextPraiseReasonSilent(33) ; "washing gently"
		DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
		if akAggressorMind != None
			DOM01.DOM04.NotifyShowering(actor_alias,wash_type,true)
			actor_alias.SendExternalEventSSB("WashMe",wash_type,true)
			akAggressorMind.TrainSkillSlaver(0.5)
			akAggressorMind.CheckAndRegisterKink(107,1.0) ; "managing slaves"
		else
			DOM01.TrainSkillSlaver(akAbuser,0.5)
		endif
	endif	
	return broken
EndFunction

int Function StartComfortingWith(Actor akAbuser, string type)
	int broken = 0
	float mod = DOM01.GetPredatorModifier(akAbuser)
	if type == "guilt"
		abuse_type = "psychological"
		if !StartGuilt()
			SetNextPunishmentReasonForceMessage(17,"doesn't care about your guiltful words") ; "didnt listen"
		else
			TrainAnger(DOM01.train_speed_tell*0.2*MOD_Gentleness*mod)
			number_of_toldoff += 1 
			SendNotificationAbuse("Pretending to comfort "+GetMoodNameThirdPerson()+name+" with "+type)
			broken = 1 
		endif
	elseif type == "insult"
		abuse_type = "psychological"
		if !StartInsultCrying()
			SetNextPunishmentReasonForceMessage(17,"doesn't care about your insulting words"); "didnt listen"
			return 0
		else
			TrainRespect(DOM01.train_speed_tell*0.2*MOD_Rebellion*mod)
			number_of_insult += 1
			SendNotificationAbuse("Pretending to comfort "+GetMoodNameThirdPerson()+name+" with "+type)
			broken = 1
		endif
	elseif type == "threat"
		abuse_type = "psychological"
		if !StartInsultCrying()
			SetNextPunishmentReasonForceMessage(17,"doesn't care about your threatening words") ; "didnt listen"
			return 0
		else
			TrainResignation(DOM01.train_speed_tell*0.1*MOD_SumAll*mod)
			number_of_threat += 1
			SendNotificationAbuse("Pretending to comfort "+GetMoodNameThirdPerson()+name+" with "+type)
			broken = 1
		endif
	elseif type == "pain"
		abuse_type = "physical"
		TrainResignation(DOM01.train_speed_tell*0.1*mod)
		SendNotificationAbuse("Pretending to comfort "+GetMoodNameThirdPerson()+name+" with "+type)
		StartPunishingByIndex(akAbuser,4,"pain") ; "crying"
		return 3
	elseif type == "rape"
		abuse_type = "sexual"
		TrainSubmission(DOM01.train_speed_tell*0.1*mod)
		SendNotificationAbuse("Pretending to comfort "+GetMoodNameThirdPerson()+name+" with "+type)
		force_crying_as_punishment_reason = true
		actor_alias.Anim_Sexlab(akAbuser, "Vaginal", true) ; punishment
		return 3
	else
		if !IsComforted()
			SetNextPunishmentReasonForceMessage(17,"doesn't want to be comforted") ; "didnt listen"
			broken = 0
		endif
	
		if type == "care"
			abuse_type = "psychological"
			if !StartGuilt()
				SetNextPunishmentReasonForceMessage(17,"doesn't care about your feelings") ; "didnt listen"
				broken = 0
			else
				float amount = DOM01.train_speed_tell*0.1*MOD_Consideration*mod
				TrainRespect(amount)
				TrainAnger(amount)
				actor_alias.Anim_GetPlayerHug()
				number_of_comfort += 1 
				SendNotificationAbuse("Comforting "+GetMoodNameThirdPerson()+name+" with "+type)
				DOM01.DOMPlayerAlias.HasChatWith(actor_alias)
				broken = 2
			endif
		else ;if type == "sex"
			abuse_type = "sexual+psychological" ; "sex" abuse is "sexual" + "psychological" in this case
			if !StartGuilt()
				SetNextPunishmentReasonForceMessage(17,"doesn't care about your tenderness") ; "didnt listen"
				broken = 0
			else
				TrainHumiliation(DOM01.train_speed_tell*0.1*mod)
				SendNotificationAbuse("Comforting "+GetMoodNameThirdPerson()+name+" with "+type)
				actor_alias.Anim_Sexlab(akAbuser, "Vaginal", false) ; not punishment
				broken = 2
			endif
			return broken
		endif
	endif
	if broken > 0
		time_last_abused = GetCurrentGameTime()
		time_last_resilience = time_last_abused
	endif
	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillPredator(0.5)
		akAggressorMind.SetNextPraiseReasonSilent(47) ; "being a perverted trainer"
		akAggressorMind.CheckAndRegisterKink(100,1.0) ; "taking advantage of slaves"
	else
		if akAbuser == PlayerRef
			bool is_broken = (broken>0)
			DOM01.DOM04.NotifyEndComforted(actor_alias,type,is_broken)
			actor_alias.SendExternalEventSSB("Comforted",type,is_broken)
		endif
		DOM01.TrainSkillPredator(akAbuser,0.5)
	endif
	return broken
EndFunction

string Function GetBestFlatter()
	int type = GetMinimalTraining()
	;LogTrace("GetBestFlatter type="+type)
	if type == 0
		return "sexy"
	endif
	if type == 1
		return "praise"
	endif
	if type == 2
		return "dirty"
	endif
	if type == 3
		return "praise"
	endif
	if type == 4
		return "praise"
	endif
	return "romance"
EndFunction

bool Function StartFlatteringWith(Actor akAbuser, string type)
	abuse_type = "psychological"
	bool broken = false
	if IsBrokenToObey() || IsObedient()
		broken = true
		DOM01.DOMPlayerAlias.HasChatWith(actor_alias)
	endif
	if type == "dirty" ; humiliation
		if !broken && RandomFloat() < MOD_Ingenuity && RandomFloat() < MOD_Daring
			broken = true
		endif
		if !broken
			MakeAngryFor(5.0)
			SetNextPunishmentReasonForceMessage(17,"does not want to listen to your dirty talk") ; "didnt listen"
		else
			IncreaseArousal(10.0,MOD_Daring)
			SendNotification(name+" seems aroused by your dirty talk")
			number_of_flatter += 1
			TrainAnger(5.0)
			TrainHumiliation(5.0)
		endif
	elseif type == "sexy" ; submission
		if !broken && RandomFloat() < MOD_Sincerity && RandomFloat() < MOD_Daring
			broken = true
		endif
		if !broken
			MakeAngryFor(5.0)
			SetNextPunishmentReasonForceMessage(17,"does not want to listen to your sexy talk") ; "didnt listen"
		else
			IncreaseArousal(10.0,MOD_Daring)
			SendNotification(name+" seems flattered by your sexy talk")
			number_of_flatter += 1
			TrainAnger(5.0)
			TrainSubmission(5.0)
		endif
	elseif type == "romance" ; respect
		if !broken && RandomFloat() < MOD_SumAll && RandomFloat() < MOD_Sentimentality
			broken = true
		endif
		if !broken
			MakeAngryFor(5.0)
			SetNextPunishmentReasonForceMessage(17,"does not want to listen to your tender words") ; "didnt listen"
		else
			IncreaseArousal(10.0,MOD_Sentimentality)
			SendNotification(name+" seems flattered by your tender words")
			number_of_flatter += 1
			TrainAnger(5.0)
			TrainRespect(5.0)
		endif
	else  ; if type == "praise" ; anger and resignation
		if !broken && RandomFloat() < MOD_Organized && RandomFloat() < MOD_Impressionable
			broken = true
		endif
		if !broken
			MakeAngryFor(5.0)
			SetNextPunishmentReasonForceMessage(17,"does not want to listen to your kind words") ; "didnt listen"
		else
			SendNotification(name+" seems flattered by your kind words")
			number_of_praise += 1
			TrainAnger(5.0)
			TrainResignation(3.0)
			TrainFear(2.0)
		endif
	endif
	if broken
		time_last_abused = GetCurrentGameTime()
		time_last_resilience = time_last_abused
	endif
	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillPredator(0.5)
		akAggressorMind.SetNextPraiseReasonSilent(47) ; "being a perverted trainer"
		akAggressorMind.CheckAndRegisterKink(100,1.0) ; "taking advantage of slaves"
	else
		if akAbuser == PlayerRef ; player
			DOM01.DOM04.NotifyEndFlatter(actor_alias,type,broken)
			actor_alias.SendExternalEventSSB("Flattered",type,broken)
		endif
		DOM01.TrainSkillPredator(akAbuser,0.5)
	endif
	return broken
EndFunction

int Function GetMinimalTraining()
	int i = 1
	float x = fear_training
	if is_love_interest
		if humiliation <= x
			i = 2
			x = humiliation
		endif
		if submission <= x
			i = 0
			x = submission
		endif
	endif
	if anger_training < x
		i = 3
		x = anger_training
	endif
	if resignation < x
		i = 4
		x = resignation
	endif
	if respect_training < x
		i = 5
		x = respect_training
	endif
	if x < 100.0
		return i
	endif
	i = 1
	x = loyal_worship
	if is_love_interest
		if love_admiration <= x
			i = 5
			x = love_admiration
		endif
		if love_fascination <= x
			i = 2
			x = love_fascination
		endif
		if love_desire <= x
			i = 0
			x = love_desire
		endif
	endif
	if loyal_absolution < x
		i = 3
		x = loyal_absolution
	endif
	if loyal_devotion < x
		i = 4
		x = loyal_devotion
	endif
	return i
EndFunction

string Function GetBestInsult()
	int type = GetMinimalTraining()
	;LogTrace("GetBestInsult type="+type)
	if type == 0
		return "dominating"
	endif
	if type == 1
		return "useless"
	endif
	if type == 2
		return "degrading"
	endif
	if type == 3
		return "demeaning"
	endif
	if type == 4
		return "disgrace"
	endif
	return "worthless"
EndFunction

bool Function StartInsultingWith(Actor akAbuser, string type)
	abuse_type = "psychological"
	bool broken = false
	if IsBrokenToObey() || IsObedient()
		broken = true
	endif
	if type == "dominating" ; submission H MOD_Greed      -H-Bo-C & MOD_Humility       +H-Wi-To
		if !broken && RandomFloat() < MOD_Greed && RandomFloat() < MOD_Humility
			broken = true
		endif
		if !broken
			MakeAngryFor(5.0)
			SetNextPunishmentReasonForceMessage(17,"does not want to listen to your insulting words") ; "didnt listen"
		else
			SendNotification(name+" seems affected by your insulting words")
			number_of_insult += 1
			MakeAshamedFor(4.0)
			TrainSubmission(4.0)
			IncreaseArousal(5.0,MOD_Discipline)
		endif
	elseif type == "useless" ; fear E MOD_Dependence +E-Bo-H  & MOD_Impressionable +E+Su+X
		if !broken && RandomFloat() < MOD_Dependence && RandomFloat() < MOD_Impressionable
			broken = true
		endif
		if !broken
			MakeAngryFor(5.0)
			SetNextPunishmentReasonForceMessage(17,"does not want to listen to your threatening") ; "didnt listen"
		else
			SendNotification(name+" seems affected by you threatening talk")
			number_of_toldoff += 1
			MakeAfraidFor(4.0)
			TrainFear(4.0)
			TrainHumiliation(2.0)
		endif
	elseif type == "degrading" ; shame X MOD_Ingenuity  -X-Sm+Se & MOD_Liveliness     +X-Wi+A
		if !broken && RandomFloat() < MOD_Ingenuity && RandomFloat() < MOD_Liveliness
			broken = true
		endif
		if !broken
			MakeAngryFor(5.0)
			SetNextPunishmentReasonForceMessage(17,"does not want to listen to your degrading talk") ; "didnt listen"
		else
			SendNotification(name+" seems affected by your degrading talk")
			number_of_insult += 1
			MakeAshamedFor(4.0)
			TrainHumiliation(4.0)
			IncreaseArousal(5.0,MOD_Discipline)
		endif
	elseif type == "demeaning" ; anger A MOD_Impatience -A-To-Wi & MOD_Gentleness     +A-Wi+H
		if !broken && RandomFloat() < MOD_Impatience && RandomFloat() < MOD_Gentleness
			broken = true
		endif
		if !broken
			MakeAngryFor(5.0)
			SetNextPunishmentReasonForceMessage(17,"does not want to listen to your hurtful words") ; "didnt listen"
		else
			SendNotification(name+" seems affected by your hurtful words")
			number_of_insult += 1
			MakeAfraidFor(4.0)
			TrainAnger(4.0)
			TrainSubmission(2.0)
		endif
	elseif type == "disgrace" ; resignation C MOD_Laborious  +C-Wi-Sm & MOD_Organized      +C-Sm-O
		if !broken && RandomFloat() < MOD_Laborious && RandomFloat() < MOD_Organized
			broken = true
		endif
		if !broken
			MakeAngryFor(5.0)
			SetNextPunishmentReasonForceMessage(17,"does not want to listen to your disgracing words") ; "didnt listen"
		else
			SendNotification(name+" seems affected by your disgraceful words")
			number_of_insult += 1
			MakeSadFor(4.0)
			TrainResignation(4.0)
			TrainRespect(2.0)
		endif
	elseif type == "worthless" ; respect O MOD_Authority  -O-Wi+C  & MOD_Manipulation   -O+Su+E
		if !broken && RandomFloat() < MOD_Authority && RandomFloat() < MOD_Manipulation
			broken = true
		endif
		if !broken
			MakeAngryFor(5.0)
			SetNextPunishmentReasonForceMessage(17,"does not want to listen to your manipulative talk") ; "didnt listen"
		else
			SendNotification(name+" seems affected by your manipulative talk")
			number_of_insult += 1
			MakeSadFor(4.0)
			TrainRespect(4.0)
			TrainFear(2.0)
		endif
	endif 
	if broken
		ticks_since_last_punished = 0
		time_last_abused = GetCurrentGameTime()
		time_last_resilience = time_last_abused
	endif
	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillDepraver(0.5)
		akAggressorMind.SetNextPraiseReasonSilent(46) ; "being a dedicated slaver"
		akAggressorMind.CheckAndRegisterKink(105,0.5) ; "humiliating slaves"
	else
		if akAbuser == PlayerRef ; player
			DOM01.DOM04.NotifyEndInsult(actor_alias,type,broken)
			actor_alias.SendExternalEventSSB("Insulted",type,broken)
		endif
		DOM01.TrainSkillDepraver(akAbuser,0.5)
	endif
	return broken
EndFunction

bool Function StartInsultCrying()
	bool broken = false
	if IsBrokenToObey() || IsObedient()
		broken = true
	elseif RandomFloat() < MOD_SumAll || RandomFloat() < MOD_Rebellion
		broken = true
	endif
	
	if !broken
		MakeAngryFor(5.0)
		return false
	endif
	
	ChooseMoodSpontaneousOnTick(0.1)

	; obedience boost, equivalent to punishlment
	ticks_since_last_punished = 0
	time_last_abused = GetCurrentGameTime()
	time_last_resilience = time_last_abused
	return true
EndFunction

bool Function StartThreatening(Actor akAbuser, string the_reason)
	abuse_type = "psychological"
	warn_punishment_reason_name = the_reason
	warn_punishment_reason = DOM01.GetJSONPunishmentReasonIndexByName(the_reason)
	number_of_threat += 1
	;LogTrace("StartThreatening: "+warn_punishment_reason_name+" idx="+__warn_punishment_reason)
	bool is_success = IsBrokenToObey() || IsObedient()
	if is_success
		time_last_abused = GetCurrentGameTime()
		time_last_resilience = time_last_abused
	endif
	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillSlaver(0.5)
		akAggressorMind.SetNextPraiseReasonSilent(45) ; "being a good slaver"
		akAggressorMind.CheckAndRegisterKink(107,1.0) ; "managing slaves"
	else
		if akAbuser == PlayerRef
			DOM01.DOM04.NotifyStartThreat(actor_alias,the_reason,is_success)
			actor_alias.SendExternalEventSSB("Threatened",the_reason,is_success)
		endif
		DOM01.TrainSkillSlaver(akAbuser,0.5)
	endif
	return is_success
EndFunction

Function StartChattingPersonality(Actor akAbuser, Faction contrl_faction, int hexaco_trait, Float base_amount)
	float hexaco_lvl
	float hexaco_mod
	Faction modify_faction
	if hexaco_trait == -(1)
		hexaco_trait = RandomInt(0,5)
	elseif hexaco_trait < 0
		hexaco_trait = RandomInt(6,11)
	endif
	if hexaco_trait == 0
		hexaco_lvl = HEXACO_Honesty
		hexaco_mod = MOD_Humility
	elseif hexaco_trait == 1
		hexaco_lvl = HEXACO_Emotionality
		hexaco_mod = MOD_Fearfulness
	elseif hexaco_trait == 2
		hexaco_lvl = HEXACO_Extraversion
		hexaco_mod = MOD_Naivety
	elseif hexaco_trait == 3
		hexaco_lvl = HEXACO_Agreeableness
		hexaco_mod = MOD_Forgiveness
	elseif hexaco_trait == 4
		hexaco_lvl = HEXACO_Conscientiousness
		hexaco_mod = MOD_Prudent
	elseif hexaco_trait == 5
		hexaco_lvl = HEXACO_Openness
		hexaco_mod = MOD_Discipline
	elseif hexaco_trait == 6
		hexaco_lvl = FACET_Wilfulness
		hexaco_mod = MOD_Criminality
	elseif hexaco_trait == 7
		hexaco_lvl = FACET_Toughness
		hexaco_mod = MOD_Sentimentality
	elseif hexaco_trait == 8
		hexaco_lvl = FACET_Sensuality
		hexaco_mod = MOD_Daring
	elseif hexaco_trait == 9
		hexaco_lvl = FACET_Submissivity
		hexaco_mod = MOD_Impatience
	elseif hexaco_trait == 10
		hexaco_lvl = FACET_Boldness
		hexaco_mod = MOD_Diligent
	elseif hexaco_trait == 11
		hexaco_lvl = FACET_Smartness
		hexaco_mod = MOD_Manipulation
	else
		return
	endif
	if hexaco_lvl >= 100.0 || hexaco_lvl <= 0.0
		return
	endif
	float multiplier
	if hexaco_lvl >= 50.0
		multiplier = 1.0
	else
		multiplier = -1.0
	endif
	int contrl_level
	if akRef.IsInFaction(contrl_faction)
		contrl_level = akRef.getFactionRank(contrl_faction)+1
		if contrl_level < 1
			contrl_level = 1
		elseif contrl_level > 125
			contrl_level = 125
		endif
	else
		contrl_level = 1
	endif
	float amount = base_amount/contrl_level
	if amount <= 0.0
		return
	endif
	;LogTrace("StartChattingPersonality 1 idx="+hexaco_trait+" mod="+hexaco_mod+" amount="+amount)
	amount = (multiplier*hexaco_mod*amount) + 0.5
	if contrl_level < 5
		if amount > 0.0 && amount < 1.0
			amount = 1.0
		elseif amount < 0.0 && amount > -(1.0)
			amount = -1.0
		endif
	endif
	;LogTrace("StartChattingPersonality 2 idx="+hexaco_trait+" trait="+hexaco_lvl+" amount="+amount)
	hexaco_lvl += amount
	if hexaco_lvl < 0.0
		hexaco_lvl = 0.0
	elseif hexaco_lvl > 100.0
		hexaco_lvl = 100.0
	endif
	if hexaco_trait == 0
		HEXACO_Honesty = hexaco_lvl
	elseif hexaco_trait == 1
		HEXACO_Emotionality = hexaco_lvl
	elseif hexaco_trait == 2
		HEXACO_Extraversion = hexaco_lvl
	elseif hexaco_trait == 3
		HEXACO_Agreeableness = hexaco_lvl
	elseif hexaco_trait == 4
		HEXACO_Conscientiousness = hexaco_lvl
	elseif hexaco_trait == 5
		HEXACO_Openness = hexaco_lvl
	elseif hexaco_trait == 6
		FACET_Wilfulness = hexaco_lvl
	elseif hexaco_trait == 7
		FACET_Toughness = hexaco_lvl
	elseif hexaco_trait == 8
		FACET_Sensuality = hexaco_lvl
	elseif hexaco_trait == 9
		FACET_Submissivity = hexaco_lvl
	elseif hexaco_trait == 10
		FACET_Boldness = hexaco_lvl
	elseif hexaco_trait == 11
		FACET_Smartness = hexaco_lvl
	else
		return
	endif
	number_of_chat_personality += 1
	akRef.setFactionRank(contrl_faction,contrl_level)
	bool is_success = IsBrokenToObey() || IsObedient()
	if akAbuser == PlayerRef
		DOM01.DOM04.NotifyEndChat(actor_alias,"personality",is_success)
	endif
	DOM01.TrainSkillDeceiver(akAbuser,0.5)
	;LogTrace("StartChattingPersonality 3 idx="+hexaco_trait+" trait="+hexaco_lvl+" ctrl="+contrl_level)
EndFunction

Function StartChattingFeelings(Actor akAbuser, Faction contrl_faction, int hexaco_trait, Float base_amount)
	int contrl_level
	if akRef.IsInFaction(contrl_faction)
		contrl_level = akRef.getFactionRank(contrl_faction)+1
		if contrl_level < 1
			contrl_level = 1
		elseif contrl_level > 125
			contrl_level = 125
		endif
	else
		contrl_level = 1
	endif
	float amount = base_amount/contrl_level
	if contrl_level < 5
		if amount < 1.0
			amount = 1.0
		endif
	endif
	;LogTrace("StartChattingFeelings 1 idx="+hexaco_trait+" amount="+amount)
	float training_level_before
	float training_level_after
	if hexaco_trait == -(1)
		hexaco_trait = RandomInt(0,5)
	elseif hexaco_trait < 0
		hexaco_trait = RandomInt(6,11)
	endif
	if hexaco_trait == 0
		training_level_before = submission
		TrainSubmission(amount)
		training_level_after = submission
	elseif hexaco_trait == 1
		training_level_before = fear_training
		TrainFear(amount)
		training_level_after = fear_training
	elseif hexaco_trait == 2
		training_level_before = humiliation
		TrainHumiliation(amount)
		training_level_after = humiliation
	elseif hexaco_trait == 3
		training_level_before = anger_training
		TrainAnger(amount)
		training_level_after = anger_training
	elseif hexaco_trait == 4
		training_level_before = resignation
		TrainResignation(amount)
		training_level_after = resignation
	elseif hexaco_trait == 5
		training_level_before = respect_training
		TrainRespect(amount)
		training_level_after = respect_training
	elseif hexaco_trait == 6
		training_level_before = vaginal_training
		TrainVaginal(amount)
		training_level_after = vaginal_training
	elseif hexaco_trait == 7
		training_level_before = anal_training
		TrainAnal(amount)
		training_level_after = anal_training
	elseif hexaco_trait == 8
		training_level_before = oral_training
		TrainOral(amount)
		training_level_after = oral_training
	elseif hexaco_trait == 9
		training_level_before = pose_training
		TrainPose(amount)
		training_level_after = pose_training
	elseif hexaco_trait == 10
		training_level_before = house_training
		TrainHouse(amount)
		training_level_after = house_training
	elseif hexaco_trait == 11
		training_level_before = combat_training
		TrainCombat(amount)
		training_level_after = combat_training
	else
		return
	endif
	number_of_chat_feelings += 1
	;LogTrace("StartChattingFeelings 2 idx="+hexaco_trait+" stat="+training_level_before+" amount="+amount)
	akRef.setFactionRank(contrl_faction,contrl_level)
	bool is_success = IsBrokenToObey() || IsObedient()
	if akAbuser == PlayerRef
		DOM01.DOM04.NotifyEndChat(actor_alias,"feelings",is_success)
	endif
	DOM01.TrainSkillDeceiver(akAbuser,0.5)
	;LogTrace("StartChattingFeelings 3 idx="+hexaco_trait+" stat="+training_level_after+" ctrl="+contrl_level)
EndFunction

bool Function StartScolding(Actor akAbuser, string the_reason)
	actor_alias.SetAsVictim(3)
	abuse_type = "psychological"
	int ireason
	if the_reason == ""
		ireason = GetAnyPunishmentReason(the_reason)
		the_reason = DOM01.GetJSONPunishmentReasonNameByIndex(ireason,actorSex)
	else
		ireason = DOM01.GetJSONPunishmentReasonIndexByName(the_reason)
	endif
	float amount = DOM01.train_speed_tell*DOM01.GetPersuaderModifier(akAbuser)
	amount = amount*DOM01.GetTrainingSpeed(akAbuser)
	;LogTrace("StartScolding() reason="+ireason+" "+the_reason+" "+DOM01.GetJSONPunishmentReasonNameByIndex(ireason,actorSex))
	TrainAfterScold(akAbuser, amount, ireason) ; 
	;LogTrace("CorrectBehaviour StartScolding")
	actor_alias.CorrectBehaviour(akAbuser,ireason,true)
	
	OnToldOff(ireason)
	bool broken = IsDevoted()
	if broken
		IncreaseArousal(5.0,MOD_Discipline)
	else
		broken = (IsBrokenToObey() || IsObedient())
	endif
	if akAbuser == PlayerRef ; player
		DOM01.DOM04.NotifyEndScold(actor_alias,the_reason,broken)
		actor_alias.SendExternalEventSSSB("Punished","scold",the_reason,broken)
	endif

	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.TrainSkillPersuader(0.5)
		akAggressorMind.SetNextPraiseReasonSilent(43) ; "being a scary trainer"
		akAggressorMind.CheckAndRegisterKink(108,1.0) ; "yelling at slaves"
	else
		DOM01.TrainSkillPersuader(akAbuser,0.5)
	endif
	actor_alias.UnsetAsVictim()
	if broken
		ticks_since_last_punished = 0
		time_last_abused = GetCurrentGameTime()
		time_last_resilience = time_last_abused
	endif
	return broken
EndFunction

bool Function StartPraising(Actor akAbuser, string the_reason, string type)
	abuse_type = "psychological"
	if type == "" 
		type = DOM01.DefaultPraiseType
	endif
	int ireason
	if the_reason == ""
		ireason = GetNextPraiseReasonByIndex()
		the_reason = DOM01.GetJSONPraisingReasonNameByIndex(ireason,actorSex)
	else
		ireason = DOM01.GetJSONPraisingReasonIndexByName(the_reason)
	endif
	float amount = DOM01.train_speed_good*DOM01.GetDeceiverModifier(akAbuser)
	amount = amount*DOM01.GetTrainingSpeed(akAbuser)
	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if akAggressorMind != None
		akAggressorMind.SetNextPraiseReasonSilent(44) ; "being a devoted slaver"
		akAggressorMind.CheckAndRegisterKink(104,1.0) ; "breaking slaves"
	endif
	DOM01.TrainSkillDeceiver(akAbuser,0.5)
	bool is_broken = TrainAfterPraise(amount,ireason,type)
	if akAbuser == PlayerRef ; player
		DOM01.DOM04.NotifyEndPraise(actor_alias,type,the_reason,!is_broken)
		actor_alias.SendExternalEventSSSB("Praised",type,the_reason,is_broken)
	endif
	return is_broken
EndFunction

bool Function StartPunishing(Actor akAbuser, string the_reason, string type)
	;LogTrace("StartPunishing reason="+the_reason+" type="+type)
	if type == "" 
		type = DOM01.DefaultPunishmentType
	endif
	;LogTrace("StartPunishing whipping_active="+whipping_active)
	if type == "pain" && whipping_active
		return false
	endif
	if type == "sex"  || type == "rape"
		if sex_active
			return false
		endif
	endif
	int ireason = GetAnyPunishmentReason(the_reason)
	return StartPunishingByIndex(akAbuser, ireason, type)
EndFunction

bool Function StartPunishingByIndex(Actor akAbuser, int ireason, string type)
	;LogTrace("StartPunishingByIndex reason="+ireason+" type="+type)
	actor_alias.SetAsVictim(1)
	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if type == "pain"
		if whipping_active
			return false
		else
			whipping_active = true
			;LogTrace("StartPunishingByIndex whipping_active="+whipping_active)
			whipping_pain_damage = 0
			cane_pain_damage = 0
			slap_pain_damage = 0
			whip_pain_damage = 0
			ticks_since_last_hit = 0
			end_punishment_on_next_tick = false
			if akAggressorMind == None
				whipping_by_trainer = false
			else
				whipping_by_trainer = true
			endif
		endif
	else
		if akAggressorMind == None
			punishing_trainee_or_trainer = false
		else
			punishing_trainee_or_trainer = true
		endif
	endif
	abuse_type = "physical"
	ticks_since_last_punished = 0
	time_last_abused = GetCurrentGameTime()
	time_last_resilience = time_last_abused
	;LogTrace("DOM StartPunishingByIndex() "+name+" reason = "+ireason)	
	string the_reason =  DOM01.GetJSONPunishmentReasonNameByIndex(ireason,actorSex)
	if type == "pain"
		if actor_alias.is_caned
			whipping_type = "cane"
		elseif actor_alias.is_whipped
			whipping_type = "whip"
		elseif actor_alias.is_slapped
			whipping_type = "slap"
		else
			whipping_type = "hit"
		endif
		whipping_reason = ireason
		whipping_reason_name = the_reason
	else
		if type == "rape"
			if hadAnalSex
				current_punishment_type = "anal rape"
			elseif hadVaginalSex
				current_punishment_type = "rape" ; "vaginal rape"
			elseif hadOralSex
				current_punishment_type = "oral rape"
			else
				current_punishment_type = "rape"
			endif
		elseif type =="sex"
			if hadAnalSex
				current_punishment_type = "anal sex"
			elseif hadVaginalSex
				current_punishment_type = "sex" ; "vaginal sex"
			elseif hadOralSex
				current_punishment_type = "oral sex"
			else
				current_punishment_type = "sex"
			endif
		else
			current_punishment_type = type
		endif
		current_punishment_reason = ireason
		current_punishment_reason_name = the_reason
	endif
	if akAbuser == PlayerRef
		if type == "pain"
			if actor_alias.is_slapped
				SendNotificationAbuseForReason("Start punishment of "+GetMoodNameThirdPerson()+name+" with slaps",the_reason)	
			elseif actor_alias.is_caned
				SendNotificationAbuseForReason("Start punishment of "+GetMoodNameThirdPerson()+name+" with cane",the_reason)	
			elseif actor_alias.is_whipped
				SendNotificationAbuseForReason("Start punishment of "+GetMoodNameThirdPerson()+name+" with whip",the_reason)	
			else
				SendNotificationAbuseForReason("Start punishment of "+GetMoodNameThirdPerson()+name+" with pain",the_reason)
			endif
		else
			SendNotificationAbuseForReason("Start punishment of "+GetMoodNameThirdPerson()+name+" with "+type,the_reason)
		endif
	elseif akAggressorMind != None
		SendNotificationAbuseForReason(akAggressorMind.actor_alias.getTitle()+akAggressorMind.getName()+ " starts punishment of "+GetMoodNameThirdPerson()+name+" with "+type,the_reason)	
	endif
	;LogTrace("CorrectBehaviour StartPunishingByIndex")
	actor_alias.CorrectBehaviour(akAbuser,ireason,true)
	return IsBrokenToObey() || IsObedient()
EndFunction

Function EndPunishing(Actor akAbuser, string type)
	;LogTrace("EndPunishing Punished with type="+type+" whip="+whip_pain_damage+" slap="+slap_pain_damage+" cane="+cane_pain_damage+" sexwithplayer="+actor_alias.has_sex_with_player)
	int reason_index
	string reason_name
	if type == "pain"
		if cane_pain_damage > 0
			CheckAndRegisterKink(29,0.15) ; "being caned"
		endif		
		if slap_pain_damage > 0
			CheckAndRegisterKink(2,0.15) ; "being slapped"
		endif		
		if whip_pain_damage > 0
			CheckAndRegisterKink(1,0.1) ; "being whipped"
		endif

		whipping_active = false
		;LogTrace("EndPunishing whipping_active="+whipping_active)
		; if punishing for no reason, try to find a recent one
		if whipping_reason <= 0
			whipping_reason = GetNextPunishmentReasonByIndex()
			whipping_reason_name = DOM01.GetJSONPunishmentReasonNameByIndex(whipping_reason,actorSex)
		endif
		reason_index = whipping_reason
		reason_name  = whipping_reason_name
		whipping_reason = 0
		whipping_reason_name = "no reason"
	else
		; if punishing for no reason, try to find a recent one
		if current_punishment_reason <= 0
			current_punishment_reason = GetNextPunishmentReasonByIndex()
			current_punishment_reason_name = DOM01.GetJSONPunishmentReasonNameByIndex(current_punishment_reason,actorSex)
		endif
		reason_index = current_punishment_reason
		reason_name  = current_punishment_reason_name
		current_punishment_reason = 0
		current_punishment_reason_name = "no reason"
	endif
	
	; Apply training
	float amount
	if type == "rape" 
		amount = DOM01.train_speed_rape * DOM01.GetPredatorModifier(akAbuser)
	else
		amount = DOM01.train_speed_pain * DOM01.GetEnforcerModifier(akAbuser)
	endif
	float training_speed = DOM01.GetTrainingSpeed(akAbuser)
	amount = amount*training_speed
	DOM_Mind akAggressorMind = DOM01.GetActorMind(akAbuser)
	if akAbuser != PlayerRef
		if akAggressorMind != None
			LogTrace("Training: efficiency for DOM NPC "+akAggressorMind.GetName()+" amount="+amount+" skill="+akAggressorMind.skill_enforcer+"/"+akAggressorMind.skill_predator+" speed="+training_speed)
		else
			LogTrace("Training: efficiency for NPC "+akAbuser.GetDisplayName()+" amount="+amount+" skill="+DOM01.GetEnforcerModifier(akAbuser)+" "+DOM01.GetPredatorModifier(akAbuser)+" speed="+training_speed)
		endif
	else
		if akAggressorMind != None
			LogTrace("Training: efficiency for DOM Player "+akAggressorMind.GetName()+" amount="+amount+" skill="+akAggressorMind.skill_enforcer+"/"+akAggressorMind.skill_predator+" speed="+training_speed)
		else
			LogTrace("Training: efficiency for Player "+akAbuser.GetDisplayName()+" amount="+amount+" skill="+DOM01.GetEnforcerModifier(akAbuser)+" "+DOM01.GetPredatorModifier(akAbuser)+" speed="+training_speed)
		endif
	endif
	if type == "rape"
		; correct amount to sexual sensivity
		float mod = 0.0
		if hadAnalSex && MOD_Anal > mod
			mod = MOD_Anal
		endif
		if hadOralSex && MOD_Oral > mod
			mod = MOD_Oral
		endif
		if hadVaginalSex && MOD_Vaginal > mod
			mod = MOD_Vaginal
		endif
		;LogTrace("EndPunishing() training factor was "+amount+" changed to "+amount*(mod+0.5)+" had sex OVA="+hadOralSex+" "+hadVaginalSex+" "+hadAnalSex)
		amount *= (mod+0.5)
	endif
	TrainAfterPunished(akAbuser, amount, reason_index, type)
	;LogTrace("CorrectBehaviour EndPunishing")
	actor_alias.CorrectBehaviour(akAbuser,reason_index,true)
	if reason_index > 0
		RemoveNextPunishmentReason(reason_index)
		last_punishment_reason = reason_index
		last_punishment_reason_name = reason_name
	elseif IsDevoted()
		last_punishment_reason = 0
		last_punishment_reason_name = "no reason"
	endif
	DOM01.TrainSkillEnforcer(akAbuser,0.1)
	;PrintTrainingAfter("end punishing "+type,amount,reason_name)
	ticks_since_last_punished = 0
	time_last_abused = GetCurrentGameTime()
	time_last_resilience = time_last_abused
	whipping_by_trainer = false
	actor_alias.UnsetAsVictim()
EndFunction

; ### Train after event
Float[] _before_training
Float[] Property before_training
	Float[] Function Get()
		if !_before_training
			_before_training = new Float[16] ; 16 training stats
		endif
		return _before_training
	EndFunction
EndProperty

Function PrintTrainingBefore(string type, Float severity, string reason)
	;return
	if !DOM01.verboseMode
		return
	endif
	
	;string the_title = "Before"
	;LogTrace("Training: "+the_title+" "+type+" "+severity+" "+reason)
	before_training[0] = submission
	before_training[1] = fear_training
	before_training[2] = humiliation
	before_training[3] = anger_training
	before_training[4] = resignation
	before_training[5] = respect_training
	
	before_training[6] = pose_training
	before_training[7] = oral_training
	before_training[8] = vaginal_training
	before_training[9] = anal_training
	before_training[10] = sex_training
	before_training[11] = combat_training

	before_training[12] = house_training
	before_training[13] = work_training
	before_training[14] = skill_enforcer
	before_training[15] = skill_depraver
EndFunction

Function PrintTrainingAfter(string type, Float severity, string reason)
	;return
	if !DOM01.verboseMode
		return
	endif
	
	
	string the_title = "After"
	LogTrace("Training: "+the_title+" "+type+" "+severity+" "+reason)
	if submission != before_training[0]
		LogTrace("          "+the_title+"       submission="+submission+" ["+DiffAsString(submission,before_training[0])+"]")
	endif
	if fear_training != before_training[1]
		LogTrace("          "+the_title+"    fear_training="+fear_training+" ["+DiffAsString(fear_training,before_training[1])+"]")
	endif
	if humiliation != before_training[2]
		LogTrace("          "+the_title+"      humiliation="+humiliation+" ["+DiffAsString(humiliation,before_training[2])+"]")
	endif
	if anger_training != before_training[3]
		LogTrace("          "+the_title+"   anger_training="+anger_training+" ["+DiffAsString(anger_training,before_training[3])+"]")
	endif
	if resignation != before_training[4]
		LogTrace("          "+the_title+"      resignation="+resignation+" ["+DiffAsString(resignation,before_training[4])+"]")
	endif
	if respect_training != before_training[5]
		LogTrace("          "+the_title+" respect_training="+respect_training+" ["+DiffAsString(respect_training,before_training[5])+"]")
	endif
	if pose_training != before_training[6]
		LogTrace("          "+the_title+"    pose_training="+pose_training+" ["+DiffAsString(pose_training,before_training[6])+"]")
	endif
	if oral_training != before_training[7]
		LogTrace("          "+the_title+"    oral_training="+oral_training+" ["+DiffAsString(oral_training,before_training[7])+"]")
	endif
	if vaginal_training != before_training[8]
		LogTrace("          "+the_title+" vaginal_training="+vaginal_training+" ["+DiffAsString(vaginal_training,before_training[8])+"]")
	endif
	if anal_training != before_training[9]
		LogTrace("          "+the_title+"    anal_training="+anal_training+" ["+DiffAsString(anal_training,before_training[9])+"]")
	endif
	if sex_training != before_training[10]
		LogTrace("          "+the_title+"     sex_training="+sex_training+" ["+DiffAsString(sex_training,before_training[10])+"]")
	endif
	if combat_training != before_training[11]
		LogTrace("          "+the_title+"  combat_training="+combat_training+" ["+DiffAsString(combat_training,before_training[11])+"]")
	endif
	if house_training != before_training[12]
		LogTrace("          "+the_title+"   house_training="+house_training+" ["+DiffAsString(house_training,before_training[12])+"]")
	endif
	if work_training != before_training[13]
		LogTrace("          "+the_title+"    work_training="+work_training+" ["+DiffAsString(work_training,before_training[13])+"]")
	endif
	if skill_enforcer != before_training[14]
		LogTrace("          "+the_title+"  skill_enforcer="+skill_enforcer+" ["+DiffAsString(skill_enforcer,before_training[14])+"]")
	endif
	if skill_depraver != before_training[15]
		LogTrace("          "+the_title+"   skill_depraver="+skill_depraver+" ["+DiffAsString(skill_depraver,before_training[15])+"]")
	endif
EndFunction

float anger_factor = 0.0
Function TrainAfterPunished(Actor akAbuser, Float severity, int reason, string type)
	string the_reason = DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex)
	;LogTrace("TrainAfterPunished() "+name+" type="+type+" amount="+severity+" reason="+the_reason+" hasPlayer="+HasPlayer)	
	PrintTrainingBefore("punished "+type,severity,the_reason)
	if WasWarned(reason)
		severity *= 2.0
		SendNotificationEmotion(name+" was warned against "+the_reason)
		TrainRespect(0.05*DOM01.train_speed_tell*DOM01.GetSlaverModifier(akAbuser))
	endif
	
	String behs = actor_alias.GetBehaviourString()
	Float mod = actor_alias.GetBehaviourModifier()
	severity *= mod
	anger_factor = 0.0

	if promiseOath == "to be gentle"
		if IsInLove()
			if promise_kept == 0
				promise_kept = -(1)
			endif
		else
			promise_kept = -(1)
		endif
		anger_factor += 2.5
		severity *= 0.75
	elseif promiseOath == "pain"
		promise_kept = 1
		severity *= 1.15
	endif

	if mood == "shock" ; Slave is in shock
		if reason <= 0 ;  "no reason"
			reason = 9 ; "being a bad slave"
			the_reason = DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex)
		endif
	endif
	if number_of_pain <= 2 && reason == 0
		reason = 9 ; "being a bad slave"
		severity *= 2.5 - (number_of_pain as float)/2.0
	endif
	if WasPunishedFor(reason)
		severity *= 1.2 ; Use reinforcement
		if type == "pain" && whipping_pain_damage >= 2
			if reason > 0
				SendNotification("Punishing "+GetMoodNameThirdPerson()+behs+name+" with "+whipping_pain_damage+" strokes for "+the_reason+" again")
			else
				SendNotification("Punishing "+GetMoodNameThirdPerson()+behs+name+" with "+whipping_pain_damage+" strokes for no particular reason")
			endif
		elseif reason > 0
			SendNotification("Punishing "+GetMoodNameThirdPerson()+behs+name+" with "+type+" for "+the_reason+" again")
		else
			SendNotification("Punishing "+GetMoodNameThirdPerson()+behs+name+" with "+type+" for no particular reason")
		endif
		anger_factor += 5.0
	elseif type == "pain" && whipping_pain_damage >= 2
		SendNotification("Punishing "+GetMoodNameThirdPerson()+behs+name+" with "+whipping_pain_damage+" strokes for "+the_reason)
	else
		SendNotification("Punishing "+GetMoodNameThirdPerson()+behs+name+" with "+type+" for "+the_reason)	
	endif
	float modifier = 0.5
	if whipping_pain_damage > 0
		if whipping_pain_damage == 1
			modifier = 0.6
		else
			modifier = 0.6+Math.atan((whipping_pain_damage as float)-(1.0))/100.0
		endif
	endif
	;SendNotificationEmotion("Punishment damage =  "+whipping_pain_damage+" "+modifier+" "+severity+" = "+severity*modifier)	
	severity *= modifier
	
	if DOM01.friendToggle
		bool bFriends = actor_alias.TrainFriends(reason, type, severity * 0.1)
	endif

	; Extra punishment for wearing degrading devices
	TrainForWornDevice(severity,reason)

	; Extra punishment depending on type
	if type == "pain"
		number_of_pain += 1
		severity *= getPainMultiplier()
		TrainFear(severity * 0.03)
	elseif type == "rape"
		if actor_alias.has_sex_with_player
			number_of_rape += 1
		endif
		severity *= getRapeMultiplier()
		TrainAnger(severity * 0.03)
	elseif type == "public humiliation"
		number_of_insult += 1
		IncreaseArousal(5.0,MOD_Naivety)
	elseif type == "choke"
		number_of_shame += 1
		IncreaseArousal(5.0,MOD_Sociability)
	elseif type == "spank"
		number_of_shame += 1
		IncreaseArousal(5.0,MOD_Ingenuity)
	elseif type == "slap boobs"
		number_of_shame += 1
		IncreaseArousal(10.0,MOD_Humility)
	elseif type == "slap face"
		number_of_shame += 1
		IncreaseArousal(10.0,MOD_Discipline)
	else
		number_of_shame += 1
		IncreaseArousal(10.0,MOD_Authority)
	endif

	; Main punishment reason
	TrainForReason(severity,reason)
	if type != "pain" && type != "rape" && type != "sex" ; already handled by OnHit and OnEndSex
		;LogTrace("TrainAfterPunished calling OnExperiencePain type="+type)
		OnExperiencePain()
	endif

	OnEndPunishment(severity)
	if akAbuser == PlayerRef && type != "rape" && type != "sex"
		bool is_broken = IsBrokenToObey() || IsObedient()
		if type == "pain"
			;LogTrace("TrainAfterPunished calling NotifyEndPunishment current whip="+whipping_type+" type="+type)
			DOM01.DOM04.NotifyEndPunishment(actor_alias,whipping_type,the_reason,whipping_pain_damage)
			actor_alias.SendExternalEventSSSB("Punished",whipping_type,the_reason,is_broken)
		else
			;LogTrace("TrainAfterPunished calling NotifyEndPunishment current type="+current_punishment_type+" type="+type)
			DOM01.DOM04.NotifyEndPunishment(actor_alias,current_punishment_type,the_reason,whipping_pain_damage)
			actor_alias.SendExternalEventSSSB("Punished",current_punishment_type,the_reason,is_broken)
		endif
	endif
	; -=TAK=- Relationship rank will go back up after stockholm syndrom
	DegradeRelationship()

	; update mind change mood parameters now
	UpdateRegistered()
	;PrintTrainingAfter("punished "+type,severity,the_reason)
EndFunction

Function TrainAfterScold(Actor akAbuser, float amount, int reason)
	string the_reason = DOM01.GetJSONPunishmentReasonNameByIndex(reason,actorSex)
	Float severity = amount*GetScoldMultiplier()
	PrintTrainingBefore("scold",severity,the_reason)
	if WasWarned(reason)
		severity *= 2.0
		SendNotificationEmotion(name+" was warned against "+the_reason)
		TrainRespect(0.05*DOM01.train_speed_tell*DOM01.GetSlaverModifier(akAbuser))
	endif

	String behs = actor_alias.GetBehaviourString()
	Float mod = actor_alias.GetBehaviourModifier()
	severity *= mod

	anger_factor = 0.0
	if promiseOath == "to be gentle"
		if promise_kept == 0
			promise_kept = 1
		endif
		severity *= 1.15
	elseif promiseOath == "pain"
		severity *= 0.75
	endif

	if WasPunishedFor(reason)
		severity *= 1.2 ; Use reinforcement
		if reason > 0
			SendNotification("Scolding "+GetMoodNameThirdPerson()+behs+name+" for "+the_reason+" again")	
		else
			SendNotification("Scolding "+GetMoodNameThirdPerson()+behs+name+" for no particular reason")
		endif
		anger_factor += 5.0
	else
		SendNotification("Scolding "+GetMoodNameThirdPerson()+behs+name+" for "+the_reason)	
	endif

	if DOM01.friendToggle
		bool bFriends = actor_alias.TrainFriends(reason, "scold", severity*0.05)
	endif
	
	if mood == "shock"
		severity = severity*0.2 ; Slave is in shock, not listening
	endif
	
	; Extra punishment based on bondage devices
	TrainForWornDevice(severity*(0.3 + MOD_Ingenuity),reason)
			
	; Main punishment reason
	TrainForReason(severity*(0.6 + MOD_SumAll),reason)
	
	; Extra punishment depending on type
	if reason != "no reason"
		TrainRespect(severity*0.1)
		number_of_toldoff += 1
	endif
	
	; -=TAK=- Relationship will go up after stockholm syndrom
	DegradeRelationship()

	RemoveNextPunishmentReason(reason)
	if reason > 0
		last_toldoff_reason = reason
		last_toldoff_reason_name = the_reason
	elseif IsDevoted()
		last_toldoff_reason = 0
		last_toldoff_reason_name = "no reason"
	endif

	;LogTrace("TrainAfterScold reason="+the_reason+"/"+last_toldoff_reason_name)
	; update mind change mood parameters now
	UpdateRegistered()
	;PrintTrainingAfter("scold",severity,the_reason)
EndFunction

bool Function TrainAfterPraise(float amount, int praise_reason, string type)
	if  praise_reason <= 0 
		praise_reason = GetNextPraiseReasonByIndex()
	endif
	bool broken = false
	if IsBrokenToObey() || IsObedient()
		broken = true
	elseif RandomFloat()*2.0+0.5 < MOD_SumAll
		broken = true
	endif
	if broken && praise_reason <= 0 ;  "no reason"
		if is_slave
			praise_reason = 1 ; "being a good slave"
		else
			praise_reason = 40 ; "being a slaver"
		endif
	endif
	if praise_reason == 1 && !is_Slave
		praise_reason = 40 ; "being a slaver"
	elseif praise_reason == 40 && is_Slave
		praise_reason = 1 ; "being a good slave"
	endif
	string praise_reason_name = DOM01.GetJSONPraisingReasonNameByIndex(praise_reason,actorSex)
	Float base_amount = amount*getPraiseMultiplier()/20.0 ; mood modifier

	anger_factor = 0.0
	Float multiplier = 0.1 + (0.5*(1.0-(anger_training/100.0))) + MOD_SumAll

	if mood == "shock" ; Slave is in shock, not responsive
		multiplier = 0.1
	endif

	if promiseOath == "to be gentle"
		if promise_kept == 0
			promise_kept = 1
		endif
		base_amount *= 1.15
	elseif promiseOath == "pain"
		base_amount *= 0.75
	endif
	
	;LogTrace("TrainAfterPraise: respect="+respect_training+" amount="+base_amount+" type="+type)

	float severity = base_amount * 10.0
	
	LogTrace("TrainAfterPraise reason="+praise_reason+" severity="+severity)
	; Get praise consequences from JSON
	string mod_check   = DOM01.GetJSONPraisingTrainingCheckByIndex(praise_reason)
	string mod_arousal = DOM01.GetJSONPraisingArousalModifierByIndex(praise_reason)
	string[] mod_stats = DOM01.GetJSONPraisingTrainingStatsByIndex(praise_reason)
	float[] mod_values = DOM01.GetJSONPraisingTrainingValuesByIndex(praise_reason)
	
	bool is_obedient
	if mod_check == ""
		is_obedient = true
	else
		float xcheck = GetTrainingByName(mod_check)
		if xcheck < 0.0
			LogTrace("TrainAfterPraise: ERROR could not find stat to check for reason "+praise_reason)
			if broken
				is_obedient = true
			else
				is_obedient = false
			endif
		elseif broken || RandomFloat() < xcheck
			is_obedient = true
		else
			is_obedient = false
		endif
	endif
	
	if is_obedient
		bool is_success = TrainFromArrays(severity,mod_arousal,mod_stats,mod_values)
		if !is_success
			LogTrace("TrainAfterPraise: ERROR could not train for reason "+praise_reason)
		endif
	else
		anger_factor += base_amount
	endif

	int n = DOM01.GetJSONNumberOfPraisingReasons()
	if praise_reason <= 0 ; "no reason" 
		praise_reason_name = "being a slave"
		anger_factor += base_amount
		if broken || RandomFloat() < respect_training
			TrainAnger(base_amount)
			IncreaseArousal(base_amount*5.0,MOD_Authority)
		endif
	elseif praise_reason >= n
		SendNotification("Confusing "+GetMoodNameThirdPerson()+name+" UNREGISTERED REASON = "+praise_reason+" "+DOM01.GetJSONPraisingReasonNameByIndex(praise_reason,actorSex))	
		TrainResignation(severity * 0.05)
	endif
	bool got_angry
	if anger_factor > 0.0
		SendNotification("Praising an unresponsive "+name+" with "+type+" for "+praise_reason_name)
		MakeAngryFor(anger_factor)
		anger_factor = 0.0
		got_angry = true
	else
		SendNotification("Praising "+GetMoodNameThirdPerson()+name+" with "+type+" for "+praise_reason_name)
		if praise_reason > 0
			number_of_praise += 1 ; Otherwise does not count as praising
			ticks_since_last_punished += 5
		endif		
		DOM01.DOMPlayerAlias.HasChatWith(actor_alias)
		got_angry = false
	endif
	RemoveNextPraiseReason(praise_reason)
	last_praise_reason = praise_reason
	last_praise_reason_name = praise_reason_name
	if got_angry
		return false
	endif
	time_last_abused = GetCurrentGameTime()
	time_last_resilience = time_last_abused	
	return true
EndFunction

Function TrainAfterShock()
; This is a chance to get PTSD
; PTSD symptoms: trauma and -honesty -calm -extraversion
; Stress:       -calm -extraversion -kind
; Negative affect:  -honesty -calm -extraversion -kind
	if DOM01.staticTraitsMode
		return
	endif

	Float base_chance = MOD_Sincerity
	; Chance modifiers from past abuse
	int nshock = number_of_shock-(1)+number_of_broken; -1 because a shock just occured
	float wp = 30.0/(1.0+MOD_Humility)
	float wb = 30.0/(1.0+MOD_Sociability)
	float ws = 30.0/(1.0+MOD_Naivety)
	float wx = 30.0/(1.0+MOD_Consideration)
	float wr = 30.0/(1.0+MOD_Prudent)
	float wt = 30.0/(1.0+MOD_Discipline)
	float wz = 30.0/(1.0+MOD_Forgiveness) 
	float wy = 30.0/(1.0+MOD_Empathy) 
	float wc = 30.0/(1.0+MOD_Consideration) 
	float wi = 30.0/(1.0+MOD_Rebellion) 
	float wh = 30.0/(1.0+MOD_Fearfulness) 
	float wf = 30.0/(1.0+MOD_Impressionable) 
	float ww = 30.0/(1.0+MOD_Hope) 
	float wv =  1.0/(1.0+MOD_Ingenuity) 
	; Number of times punished
	float np = (number_of_pain    - nshock*wp)
	float nb = (number_of_bondage - nshock*wb)
	float ns = (number_of_shame   - nshock*ws)
	float nx = (number_of_sex     - nshock*wx)
	float nr = (number_of_rape    - nshock*wr)
	float nt = (number_of_toldoff - nshock*wt)
	float nz = (number_of_praise  - nshock*wz)
	float ny = (number_of_chat_feelings + number_of_chat_personality - nshock*wz)
	float nc = (number_of_comfort - nshock*wc)
	float ni = (number_of_insult  - nshock*wi)
	float nf = (number_of_flatter - nshock*wf)
	float nh = (number_of_threat  - nshock*wh)
	float nw = (number_of_promise - nshock*ww)
	float nv = (new_sexual_experiences - nshock*wv)
	if np < 0
		np = 0
	endif
	if nb < 0
		nb = 0
	endif
	if ns < 0
		ns = 0
	endif
	if nx < 0
		nx = 0
	endif
	if nr < 0
		nr = 0
	endif
	if nt < 0
		nt = 0
	endif
	if nz < 0
		nz = 0
	endif
	if ny < 0
		ny = 0
	endif
	if nc < 0
		nc = 0
	endif
	if ni < 0
		ni = 0
	endif
	if nh < 0
		nh = 0
	endif
	if nf < 0
		nf = 0
	endif
	if nw < 0
		nw = 0
	endif
	if nv < 0
		nv = 0
	endif
	if number_of_sex > number_of_rape*2.0
		nv = -nv
	endif
	Float pnsh_chance = (np/wp+nb/wb+ns/ws-nx/wx+nr/wr+nt/wt-nz/wz-ny/wy-nc/wc+ni/wi-nf/wf+nh/wh+nw/ww+nv/wv)
	float chance = base_chance*pnsh_chance
	;LogTrace("Shock n = "+nshock+" n = "+number_of_pain+" "+number_of_shame+" "+number_of_sex+" "+number_of_rape+" "+number_of_toldoff+" "+number_of_praise+" "+number_of_comfort+" "+number_of_insult+" "+number_of_flatter)
	;LogTrace("Shock n = "+nshock+" z = "+np+" "+nb+" "+ns+" "+nx+" "+nr+" "+nt+" "+nz+" "+nc+" "+ni+" "+nh+" "+nw+" "+nf+" "+nv)
	;LogTrace("Shock n = "+nshock+" w = "+wp+" "+wb+" "+ws+" "+wx+" "+wr+" "+wt+" "+wz+" "+wc+" "+wi+" "+wh+" "+ww+" "+wf+" "+wv)
	;LogTrace("after shock chance= "+chance)
	
	if RandomFloat() < chance
		float amount = MOD_Anxiety*10.0
		amount *= 5.0/(number_of_shock+5.0) ; less efficient after a few shocks
		HEXACO_Emotionality   = HEXACO_Emotionality  - amount * DOM_Util.RandG1()
		HEXACO_Agreeableness  = HEXACO_Agreeableness - amount * DOM_Util.RandG1()
		HEXACO_eXtraversion   = HEXACO_eXtraversion  - amount * DOM_Util.RandG1()
		;LogTrace("seems to be really shaken. Amount = "+amount)
		SendNotificationEmotion(name+" seems to be really shaken")
	endif
EndFunction

; ### Weather

Function TrainForWeather(int weatherType)
	if IsDevoted()
		return
	endif
	if weatherType < 2
		return
	endif
	Float base_amount = 1.0
	if IsAfraid()
		trainFear(base_amount)
	elseif IsSad()
		trainResignation(base_amount)
	elseif IsShamed()
		TrainHumiliation(base_amount)
	elseif mood == "broken"
		TrainRespect(base_amount)
		TrainSubmission(base_amount)
	endif
EndFunction

; ### Talking or not

bool Function WillNotTalk()
	if should_be_silent && was_silent
		if RandomFloat()*100.0 < submission || RandomFloat() < MOD_Humility
			AddNextPraiseReason(5) ; "being a silent pet"
			return true
		else
			SetNextPunishmentReasonSilent(5) ; "talking"
			was_silent = false
		endif
	endif
	return false
EndFunction

bool Function WillTalkAboutFeelingsOrEmotions()
	; feelings
	if RandomFloat()*100.0 < HEXACO_eXtraversion*getFeelingMultiplier()
		return true
	endif
	; emotions
	if RandomFloat()*100.0 < HEXACO_Emotionality*getEmotionMultiplier()
		return true
	endif
	return false
EndFunction

bool Function WillTalkSpontaneously()
	if DOM01.DOMSexlab.IsAnimating(akRef)
		return true ; sex makes talking easier
	endif
	if RandomFloat()*100.0 > HEXACO_eXtraversion 
		return false ; Shy people will speak less
	endif
	if RandomFloat()*100.0 < HEXACO_Emotionality
		return false  ; Calm people will speak less
	endif

	return true
EndFunction

bool Function WillTalkForFriend()
	if RandomFloat()*100.0 > HEXACO_eXtraversion 
		return false ; Shy people will react less
	endif
	if RandomFloat()*100.0 > HEXACO_Agreeableness
		return false ; Kind people will react more
	endif

	return true
EndFunction

bool Function WillTalkForWeather()
	if RandomFloat()*100.0 > HEXACO_eXtraversion 
		;LogTrace("WillTalkForWeather: "+name+" too shy")
		return false ; Shy people will react less
	endif
	if RandomFloat()*100.0 < FACET_Toughness
		;LogTrace("WillTalkForWeather: "+name+" tough")
		return false ; Tough people will react less
	endif

	;LogTrace("WillTalkForWeather: "+name+" yes")
	return true
EndFunction

bool Function WillTalkForRival()
	if RandomFloat()*100.0 > HEXACO_eXtraversion 
		return false ; Shy people will react less
	endif
	if RandomFloat()*100.0 < HEXACO_Agreeableness
		return false ; Kind people will react less
	endif

	return true
EndFunction

bool Function WillTalkUnderPain()
	if RandomFloat()*100.0 > HEXACO_Agreeableness ; Grumpy people will speak less
		return false
	endif
	if RandomFloat()*100.0 < FACET_Wilfulness ; Strong willed people will speak less
		return false
	endif

	return true
EndFunction

int Function GetPainTopicSubject()
	float x = FACET_Toughness
	int i
	
	if x > 92
		i = RandomInt(0, 2)
		if i > 1
			return 0
		endif
		return i
	endif
	if x > 84
		i = RandomInt(0, 4)
		if i > 3
			return 0
		endif
		if i > 2
			return 1
		endif
		return i
	endif
	if x > 66
		i = RandomInt(0, 3)
		if i > 2
			return 1
		endif
		return i
	endif
	if x < 34
		i = RandomInt(1, 4)
		if i < 2
			return 3
		endif
		return i
	endif
	if x < 16
		i = RandomInt(0, 4)
		if i < 1
			return 4
		endif
		if i < 2
			return 3
		endif
		return i
	endif
	if x < 8
		i = RandomInt(3, 4)
		if i < 3
			return 4
		endif
		return i
	endif
	
	i = RandomInt(0, 6)
	if i > 4 
		return 3
	endif
	return i
EndFunction

int Function GetFriendTopicSubject()
	; type: 0=past 1=pain, 2=sexual abuse, 3=verbal abuse, 4=manipulation (being nice)
	int rank = akRef.GetFactionRank(DOM01.DOMActorFriendIsVictim)
	if rank > 0 && rank <= 4
		return rank
	endif
	Actor akVictim = DOM01.DOMPlayerAlias.playerCombatTarget.GetActorRef()
	if akVictim!=None && akVictim.IsInFaction(DOM01.DOMActorIsVictim)
		rank = akVictim.GetFactionRank(DOM01.DOMActorIsVictim)
		if rank > 0 && rank <= 4
			return rank
		endif
	endif
	return 0
EndFunction

int Function GetRivalTopicSubject()
	; type: 0=past 1=pain, 2=sexual abuse, 3=verbal abuse, 4=manipulation (being nice)
	Actor akVictim = DOM01.DOMPlayerAlias.playerCombatTarget.GetActorRef()
	if akVictim==None || !akRef.IsInFaction(DOM01.DOMActorRivalIsVictim)
		return 0 ; too late - event has passed
	endif
	int rank = akRef.GetFactionRank(DOM01.DOMActorRivalIsVictim)
	if rank <= 0 || rank > 4
		return 0
	endif
	return rank
EndFunction

int Function GetMainEmotion()
	; Get main emotion according to mood
	; Some mood make training/feelings more important and others make personality/emotions more important
	float mod_feeling = getFeelingMultiplier() ; how much feelings drive this mood
	float mod_emotion = getEmotionMultiplier() ; how much emotions drive this mood

	; emotion and training/feelings
	float sum_emotion = MOD_SumAll
	float sum_feeling = __total_training*6.0
	float sum = sum_emotion*mod_emotion+sum_feeling*mod_feeling
	
	float rand = RandomFloat(0.0, sum)
	float curr = MOD_Humility*mod_emotion+submission*mod_feeling
	if rand < curr 
		return 0
	endif
	curr += MOD_Fearfulness*mod_emotion+fear_training*mod_feeling
	if rand < curr 
		return 1
	endif
	curr += MOD_Naivety*mod_emotion+humiliation*mod_feeling
	if rand < curr 
		return 2
	endif
	curr += MOD_Forgiveness*mod_emotion+anger_training*mod_feeling
	if rand < curr 
		return 3
	endif
	curr += MOD_Prudent*mod_emotion+resignation*mod_feeling
	if rand < curr 
		return 4
	endif
	;curr += MOD_Discipline*mod_emotion+respect_training*mod_feeling
	;if rand < curr 
		return 5
	;endif
EndFunction

Function CheckPotentialSlaverFaction()
	; Check for potential Slaver faction
	; As a general rules low honest personalities make the best henchman
	; Personalities siding with bullies:  -honest -open
	if akRef.GetRelationshipRank(PlayerRef) >= 4
		akRef.setFactionRank(DOM01.DOMPotentialSlaverFaction, 1)
	elseif IsDevoted()
		if submission > 70.0 && respect_training > 70.0 && resignation > 70.0
			akRef.setFactionRank(DOM01.DOMPotentialSlaverFaction, 1)
		else
			akRef.removeFromFaction(DOM01.DOMPotentialSlaverFaction)
		endif
	elseif HEXACO_Honesty < 34.0 && HEXACO_Openness < 50.0
		float rank = (150.0-HEXACO_Honesty*2.0-HEXACO_Openness+(100.0-MOD_Insensitivity*100.0))/2.0
		float MODEnforcer = DOM01.GetEnforcerModifier(PlayerRef)
		if MODEnforcer > 0.1
			rank = rank / MODEnforcer
		else
			rank = rank * 10.0
		endif
		if rank > 127.0
			rank = 127.0
		elseif rank < 1.0
			akRef.removeFromFaction(DOM01.DOMPotentialSlaverFaction)
		else
			akRef.setFactionRank(DOM01.DOMPotentialSlaverFaction, (rank as int))
		endif
	else
		akRef.removeFromFaction(DOM01.DOMPotentialSlaverFaction)
	endif
EndFunction

Function SetDefaultTraits(float[] TraitsArray)
	HEXACO_Honesty           = TraitsArray[0] ; Sly/Honest     Hexaco: Honesty-Humility  ; HEXACO_Honesty
	HEXACO_Emotionality      = TraitsArray[1] ; Calm/Anxious   Hexaco: Emotionality 
	HEXACO_eXtraversion      = TraitsArray[2] ; Shy/Lively     Hexaco: eXtraversion 
	HEXACO_Agreeableness     = TraitsArray[3] ; Grumpy/Gentle  Hexaco: Agreeableness
	HEXACO_Conscientiousness = TraitsArray[4] ; Lazy/Thorough  Hexaco: Conscientiousness 
	HEXACO_Openness          = TraitsArray[5] ; Shallow/Open   Hexaco: Openness to Experience

	; Mind & physical power
	FACET_Wilfulness = TraitsArray[6] ; Weak minded/Wilful with a bonus from magicka, sensitive to mind attacks
	FACET_Toughness  = TraitsArray[7]; Delicate/Tough, physical sensitive, with a bonus from stamina	
	FACET_Sensuality = TraitsArray[8] ; Frigid/Sensual, sexual sensitive
	FACET_Submissivity = TraitsArray[9]; Sadistic/Masochistic = perversion orientation
	FACET_Boldness   = TraitsArray[10] ; Needy, clingy/Bold,  independant
	FACET_Smartness  = TraitsArray[11] ; Stupid/Smart   strength of the mind
EndFunction

Function SetBaseTraits(float[] TraitsArray)
	BASE_Honesty           = TraitsArray[0] ; Sly/Honest     Hexaco: Honesty-Humility
	BASE_Emotionality      = TraitsArray[1] ; Calm/Anxious   Hexaco: Emotionality 
	BASE_eXtraversion      = TraitsArray[2] ; Shy/Lively     Hexaco: eXtraversion 
	BASE_Agreeableness     = TraitsArray[3] ; Grumpy/Gentle  Hexaco: Agreeableness
	BASE_Conscientiousness = TraitsArray[4] ; Lazy/Thorough  Hexaco: Conscientiousness 
	BASE_Openness          = TraitsArray[5] ; Shallow/Open   Hexaco: Openness to Experience

	; Mind & physical power
	BASE_Wilfulness = TraitsArray[6] ; Weak minded/Wilful with a bonus from magicka, sensitive to mind attacks
	BASE_Toughness  = TraitsArray[7]; Delicate/Tough, physical sensitive, with a bonus from stamina	
	BASE_Sensuality = TraitsArray[8] ; Frigid/Sensual, sexual sensitive
	BASE_Submissivity = TraitsArray[9]; Sadistic/Masochistic = perversion orientation
	BASE_Boldness   = TraitsArray[10] ; Needy, clingy/Bold,  independant
	BASE_Smartness  = TraitsArray[11] ; Stupid/Smart   strength of the mind
EndFunction

Function SetVirginStatus(int[] vstatus)
	virgin_status_vaginal = vstatus[0]
	virgin_status_oral    = vstatus[1]
	virgin_status_anal    = vstatus[2]
	virgin_status_same    = vstatus[3]
	virgin_status_gang    = vstatus[4]
EndFunction

; ### Notifications

Function SendNotification(string msg)
	actor_alias.SendExternalEventSSBS("NotificationSent",training_status_name,is_player_slave,msg)
	; No notifcation if not in the same cell
	if !is_player_slave || (!akRef.Is3DLoaded() && !actor_alias.IsFollowingPlayer())
		LogTrace("Silent notification: "+msg)
		return
	endif
	DOM01.SendNotification(name,msg,!is_slave)
EndFunction

Function SendNotificationFriends(string msg)
	actor_alias.SendExternalEventSSBS("NotificationSent",training_status_name,is_player_slave,msg)
	; No notifcation if not in the same cell
	if !is_player_slave || (!akRef.Is3DLoaded() && !actor_alias.IsFollowingPlayer())
		LogTrace("Silent notification: "+msg)
		return
	endif
	DOM01.SendNotificationFriends(name,msg,!is_slave)
EndFunction

Function SendNotificationAction(string msg)
	actor_alias.SendExternalEventSSBS("NotificationSent",training_status_name,is_player_slave,msg)
	; No notifcation if not in the same cell
	if !is_player_slave || (!akRef.Is3DLoaded() && !actor_alias.IsFollowingPlayer())
		LogTrace("Silent notification: "+msg)
		return
	endif
	DOM01.SendNotificationAction(name,msg,!is_slave)
EndFunction

Function SendNotificationEmotion(string msg)
	actor_alias.SendExternalEventSSBS("NotificationSent",training_status_name,is_player_slave,msg)
	; No notifcation if not in the same cell
	if !is_player_slave || (!akRef.Is3DLoaded() && !actor_alias.IsFollowingPlayer())
		LogTrace("Silent notification: "+msg)
		return
	endif
	DOM01.SendNotificationEmotion(name,msg,!is_slave)
EndFunction

Function SendNotificationAbuse(string msg)
	actor_alias.SendExternalEventSSBS("NotificationSent",training_status_name,is_player_slave,msg)
	; No notifcation if not in the same cell
	if !is_player_slave || (!akRef.Is3DLoaded() && !actor_alias.IsFollowingPlayer())
		LogTrace("Silent notification: "+msg)
		return
	endif
	DOM01.SendNotificationAbuse(name,msg,!is_slave)
EndFunction

Function SendNotificationAbuseForReason(string msg, string reason)
	actor_alias.SendExternalEventSSBS("NotificationSent",training_status_name,is_player_slave,msg)
	; No notifcation if not in the same cell
	if !is_player_slave || (!akRef.Is3DLoaded() && !actor_alias.IsFollowingPlayer())
		LogTrace("Silent notification: "+msg+" for "+reason)
		return
	endif
	if stringUtil.find(reason,"didnt")>=0
		DOM01.SendNotificationAbuse(name,msg+" because "+actorPronoun+" "+reason,!is_slave)
	else
		DOM01.SendNotificationAbuse(name,msg+" for "+reason,!is_slave)
	endif
EndFunction

Function SendNotificationOrder(string msg)
	actor_alias.SendExternalEventSSBS("NotificationSent",training_status_name,is_player_slave,msg)
	; No notifcation if not in the same cell
	if !is_player_slave || (!akRef.Is3DLoaded() && !actor_alias.IsFollowingPlayer())
		LogTrace("Silent notification: "+msg)
		return
	endif
	DOM01.SendNotificationOrder(name,msg,!is_slave)
EndFunction

Function SendNotificationMaster(string msg1, string msg2)
	actor_alias.SendExternalEventSSBS("NotificationSent",training_status_name,is_player_slave,msg1+actor_owner_title+msg2)
	; No notifcation if not in the same cell
	if !is_player_slave || !IsTogetherWithFast(akRef, PlayerRef, 10000.0)
		LogTrace("Silent notification: "+msg1+actor_owner_title+msg2)
		return
	endif
	String mtr = DOM01.DOMPlayerAlias.GetPlayerTitle()
	DOM01.SendNotification(name,msg1+mtr+msg2,!is_slave)
EndFunction

Function SendNotificationActionMaster(string msg1, string msg2)
	actor_alias.SendExternalEventSSBS("NotificationSent",training_status_name,is_player_slave,msg1+actor_owner_title+msg2)
	; No notifcation if not in the same cell
	if !is_player_slave || !IsTogetherWithFast(akRef, PlayerRef, 10000.0)
		LogTrace("Silent notification: "+msg1+actor_owner_title+msg2)
		return
	endif
	String mtr = DOM01.DOMPlayerAlias.GetPlayerTitle()
	DOM01.SendNotificationAction(name,msg1+mtr+msg2,!is_slave)
EndFunction

Function SendNotificationOrderMaster(string msg1, string msg2)
	actor_alias.SendExternalEventSSBS("NotificationSent",training_status_name,is_player_slave,msg1+actor_owner_title+msg2)
	; No notifcation if not in the same cell
	if !is_player_slave || !IsTogetherWithFast(akRef, PlayerRef, 10000.0)
		LogTrace("Silent notification: "+msg1+actor_owner_title+msg2)
		return
	endif
	String mtr = DOM01.DOMPlayerAlias.GetPlayerTitle()
	DOM01.SendNotificationOrder(name,msg1+mtr+msg2,!is_slave)
EndFunction

; #### Utilities and debug

Function DegradeRelationship()
	if IsDevoted()
		return 
	endif
	int rank = akRef.getRelationshipRank(PlayerRef)
	if rank <= -4
		return
	endif
	
	if RandomFloat() < MOD_Resentment
		akRef.setRelationshipRank(PlayerRef, rank - 1)
	endif
EndFunction

Function SetExpression(int iexp, int amount)
	if actorType != 0 ; animal or creature
		return
	endif
	; 0 to 6 dialogue expressions (mouth is untouched -> compatible with mouth gag)
	; 7 neutral expression
	; 8 to 14 full face expressions
	; 15 to 16 combat expressions
	if akRef.is3dLoaded()
		if actor_alias.has_mouth_gag && iexp > 7  && iexp < 15
			akRef.SetExpressionOverride(iexp-(8),amount) 
		else
			akRef.SetExpressionOverride(iexp,amount) 
		endif
	endif
EndFunction

Function ClearExpression()
	if actorType != 0 ; animal or creature
		return
	endif
	if akRef.is3dLoaded()
		akRef.ClearExpressionOverride()
	endif
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_Mind: "+title+name+": "+msg)
EndFunction

Function LogTrace(string msg)
	if DOM01.verboseMode
		Debug.Trace("DOM_Mind: "+title+name+": "+msg)
	endif
EndFunction
