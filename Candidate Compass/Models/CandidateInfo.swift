import UIKit

func calculateAge(from dateOfBirth: Date) -> Int {
    let calendar = Calendar.current
    let currentDate = Date()
    
    let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: currentDate)
    let age = ageComponents.year ?? 0
    
    return age
}

struct Candidate: Equatable {
    let name: String
    let profilePic: UIImage
    let party: String
    let title: String
    let DOB: Date
    let website: URL?
    var age: Int {
        return calculateAge(from: DOB)
    }
    var agePlaceholder: String {
        return "##AGE##"
    }
    let originalBioLabel: String
    var bioLabel: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let ageString = "\(self.age)"
        return originalBioLabel.replacingOccurrences(of: agePlaceholder, with: ageString)
    }
    let stancesLabel: String
    let campaignLabel: String
    
    static func ==(lhs: Candidate, rhs: Candidate) -> Bool {
        return lhs.name == rhs.name
            && lhs.party == rhs.party
            && lhs.title == rhs.title
            && lhs.DOB == rhs.DOB
            && lhs.website == rhs.website
            && lhs.originalBioLabel == rhs.originalBioLabel
            && lhs.stancesLabel == rhs.stancesLabel
            && lhs.campaignLabel == rhs.campaignLabel
    }
}

func createCandidates() -> [Candidate] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d, yyyy"

    let candidates: [Candidate] = [
        Candidate(name: "Joe Biden",
                  profilePic: UIImage(named: "joebiden")!,
                  party: "Democrat",
                  title: "Incumbent President of the U.S.",
                  DOB: dateFormatter.date(from: "November 20, 1942")!,
                  website: URL(string: "http://joebiden.com/"),
                  originalBioLabel: "   Joseph Robinette Biden Jr. was born on November 20, 1942 in Scranton, Pennsylvania (Age ##AGE##). He is the incumbent President of the United States. He has a degree in history and political science from the University of Delaware, as well as a law degree from Syracuse University Law School. He served as a U.S. Senator from Delaware from 1973 to 2009, and he chaired the Senate Judiciary Committee and the Committee on Foreign Relations. He served as the 47th Vice-President of the United States under President Barack Obama from 2009 to 2017.",
                  stancesLabel: """
Gun Control:

Passed the Bipartisan Safer Communities Act, which extended background checks for gun purchasers uthe age of 21. He supports banning all assault weapons and enacting universal background checks.

Abortion:

Pro-choice (supports the original decision in Roe v. Wade).

Environment:

Believes that action must be taken against global warming and co-sponsored the Boxer-Sanders Global Warming Pollution Reduction Act. He opposes drilling for oil and reentered the Paris Agreement.

Economy:

Proposed partially reversing tax cuts of the Tax Cuts and Jobs Act of 2017.

Immigration:

Plans to strengthen admission of immigrants for Cuba, Haiti, Nicaragua, and Venezuela legally wcracking down on illegal methods of immigration.

Other:

Supports same-sex marriage rights. Supports decriminalizing marijuana, supports increased support for Ukraine and strengthening alliances with Europe.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$19,867,069

Slogan:
Finish the Job

Date of Candidacy Announcement:
April 25, 2023
"""),
        
        Candidate(name: "Robert F. Kennedy Jr.",
                  profilePic: UIImage(named: "rfk")!,
                  party: "Independent",
                  title: "Environmental Lawyer",
                  DOB: dateFormatter.date(from: "January 17, 1954")!,
                  website: URL(string: "https://www.kennedy24.com/"),
                  originalBioLabel: "   Robert F. Kennedy Jr., nephew of former president John F. Kennedy, was born on January 17, 1954 in Washington D.C (Age ##AGE##). He is an author and a lawyer. He received a bachelor’s degree in American history and literature from Harvard University, a law degree from the University of Virginia, and a master’s degree in environmental law from Pace University. He became an assistant district attorney for the Manhattan District Attorney’s Office in 1982 and founded the Pace University Environmental Litigation Clinic in 1987 and the Children’s Health Defense in 2016.",
                  stancesLabel: """
Gun Control:

Supports banning assault weapons and "common sense" gun control. Does not support banning guns.

Abortion:

Pro-choice (believes in bodily autonomy).

Environment:

Is an environmental lawyer and has worked on many environmental issues to preserve the environment.

Economy:

Supports student loan debt forgiveness. Strongly critical of the current economy as he believes it serves the rich and hurts the poor.

Immigration:

Wants to crack down on the borders and strongly opposes illegal immigration.

Other:

Strongly anti-vaccine and goes against scientific consensus of the safety of vaccines. Claims that vaccines cautism and founded the anti-vaccine organization Children's Health Defense. Supports same-sex marriage and transgender rights, but opposes transwomen participating in women's sports. Strongly opposed the COVID-19 lockdowns. He supports increased diplomacy in regards to the war in Ukraine.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$6,365,394

Slogan:
Reclaim Democracy

Date of Candidacy Announcement:
April 5, 2023
"""),
        
        Candidate(name: "Marianne Williamson",
                  profilePic: UIImage(named: "mariannewilliamson")!,
                  party: "Democrat",
                  title: "Author and Activist",
                  DOB: dateFormatter.date(from: "July 8, 1952")!,
                  website: URL(string: "https://marianne2024.com/"),
                  originalBioLabel: "   Marianne Williamson was born on July 8, 1952 in Houston, Texas (Age ##AGE##). She is an author and activist. She attended Pomona College where she studied theater and philosophy. She founded Project Angel Food in 1989 to give food to those with AIDS and co-founded The Peace Alliance in 2004 to help educate people about peacebuilding.",
                  stancesLabel: """
Gun Control:

Supports gun control and expanding background checks.

Abortion:

Pro-choice (supports abortion access).

Environment:

Calls climate change "the greatest moral challenge of our generation. Supported re-entry into the Paris Climate Accords. Supports the development of renewable energy in replacement of fossil fuels.

Economy:

Supports free healthcare, free college, and free childcare. Has very progressive and liberal views on the economy.

Immigration:

Does not support open borders but wants to loosen regulations on immigration and supports the Deferred Action for Childhood Arrivals (DACA).

Other:

She is Jewish. Supports LGBTQ rights. Supports the creation of a Department of Peace and increasing the budget for humanitarian assistance.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$1,693,528

Slogan:
A New Beginning

Date of Candidacy Announcement:
February 23, 2023
"""),
        Candidate(name: "Ryan Binkley",
                  profilePic: UIImage(named: "ryanbinkley")!,
                  party: "Republican",
                  title: "Pastor and Businessman",
                  DOB: dateFormatter.date(from: "November 19, 1967")!,
                  website: URL(string: "https://binkley2024.com/"),
                  originalBioLabel: "    Ryan Binkley was born on November 19, 1967 in Columbus, Georgia (Age 55). He is a pastor and businessman. He received a Bachelor of Business Administration in Finance and Marketing from the University of Texas at Austin and a Master of Business Administration from Southern Methodist University. He is the founder and CEO of the Generation Equity Group and is co-founder and lead pastor of the Create Church.",
                  stancesLabel: """
Gun Control:

Signed a bill making North Dakota a "Second Amendment Sanctuary State." Values the right to keep and bear arms.Believes that gun violence is a spiritual and mental health issue.

Abortion:

Pro-life.

Environment:

Supportive of expanding the use of nuclear power and increasing energy independence. Has called for responsibly growing the development of fossil fuels.

Economy:

Intent on balancing the federal budget and reducing health care costs. Has proposed a 7-Year Economic Rescue Plan to accomplish this and massively icnrease economic transparency.

Immigration:

Supports building a barrier to secure the southerm border and increased efforts to indentify potentially dangerous illegal immigrants.

Other:

Supports taking a strong stance against Russia and confronting Chinese expansionism across the world. Does not support same-sex marriage.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$2,095,427

Slogan:
The Way to Freedom

Date of Candidacy Announcement:
April 23, 2023
"""),
        
        
        Candidate(name: "Doug Burgum",
                  profilePic: UIImage(named: "dougburgum")!,
                  party: "Republican",
                  title: "Incumbent Governor of North Dakota",
                  DOB: dateFormatter.date(from: "August 1, 1956")!,
                  website: URL(string: "https://www.dougburgum.com/"),
                  originalBioLabel: "    Doug Burgum was born on August 1, 1956 in Arthur, North Dakota (Age ##AGE##). He is the incumbent Governor of North Dakota. He received a bachelor’s degree from North Dakota State University in 1978 and received a Master of Business Administration from Stanford University in 1980.",
                  stancesLabel: """
Gun Control:

Signed a bill making North Dakota a "Second Amendment Sanctuary State". Values the right to keep and bear arms.

Abortion:

Pro-life (exceptions for up to six weeks' gestation in specific cases of rape, incest, or medical emergencies).

Environment:

Supportive of the fossil fuel industry. Has plans to reach carbon neutrality by 2030 but without infringing on the fossil fuel industry or with government mandates. Only through carbon capture and sequestration.

Economy:

Signed many laws to cut taxes and exempted members of the North Dakota National Guard from paying income tax. Provided $500 million in tax relief.

Immigration:

Deployed the national guard to the Mexican border. Created the American Governors' Border Strike Force along with 25 other governors to fight illegal immigration and human trafficking.

Other:

Signed numerous anti-trans laws and banned gender-affirming care for minors. Banned the teaching of critical race theory in North Dakota K-12 schools. Supports securing the southern border and increased deterrence in foreign policy.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$11,768,301

Slogan:
Fighting for the Best of America

Date of Candidacy Announcement:
June 7, 2023
"""),
        
        Candidate(name: "Chris Christie",
                  profilePic: UIImage(named: "chrischristie")!,
                  party: "Republican",
                  title: "Former Governor of New Jersey",
                  DOB: dateFormatter.date(from: "September 6, 1962")!,
                  website: URL(string: "https://chrischristie.com/"),
                  originalBioLabel: "    Chris Christie was born on September 6, 1962 in Newark, New Jersey (Age ##AGE##). He is the former Governor of New Jersey. He received a Juris Doctor from Seton Hall University School of Law in 1987 and was admitted to the New Jersey bar and the U.S. District Court shortly after. He became the U.S. Attorney for New Jersey in 2001.",
                  stancesLabel: """
Gun Control:

Believes gun rights should be a state issue without federal interference. However, he appears to support gun rights and the Second Amendment.

Abortion:

Pro-life (doesn’t want to force others not to get an abortion).

Environment:

Stated that the New Jersey Department of Environmental Protection is too big and is killing business. Supports renewable energy.

Economy:

Supports tax cuts and promised to not raise taxes as governor.

Immigration:

Supports securing the border. Stated that "undocumented people [in America] are not criminals unless they re-enter the country after being deported."

Other:

Extremely critical of Trump and the Trump administration. Previously opposed same-sex marriage but supported civil unions for same-sex couples. Signed a bill outlawing gay conversion therapy and seems to currently have no issue with same-sex marriage. Opposes the legalization of recreational use of marijuana. Strongly in favor of U.S. support to Ukraine and supports taking a hard stance against China.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$1,656,386

Slogan:
Because the Truth Matters

Date of Candidacy Announcement:
June 6, 2023
"""),
        
        Candidate(name: "Ron DeSantis",
                  profilePic: UIImage(named: "rondesantis")!,
                  party: "Republican",
                  title: "Incumbent Governor of Florida",
                  DOB: dateFormatter.date(from: "September 14, 1978")!,
                  website: URL(string: "https://rondesantis.com/"),
                  originalBioLabel: "    Ron DeSantis was born on September 14, 1978 in Jacksonville, Florida (Age ##AGE##). He is the incumbent Governor of Florida. He received a bachelor’s degree in history at Yale and a Juris Doctor from Harvard Law School in 2005. He served in the U.S. Navy from 2004 to 2010 and represented Florida's 6th district in the House of Representatives from 2012 to 2018 when he was elected Governor of Florida.",
                  stancesLabel: """
Gun Control:

He opposes gun control.

Abortion:

Pro-life (except for in cases of the mother’s health).

Environment:

Opposes increased environmental regulations.

Economy:

Supports lowering taxes. In 2015, introduced the Let Seniors Work Act that repealed an incentive to retire and encouraged people to keep working.

Immigration:

In 2019, signed an anti-sanctuary city bill. Supports heavier enforcement of immigration and sends immigrants to other states.

Other:

Banned transgender girls and women from participating in primary school and college women's sports in Florida. Supports the Florida Parental Rights in Education Act (Don't Say Gay) that would ban the discussion of sexual orientation or gender identity in school from kindergarten to third grade. Supports a hard stance against China and limiting U.S. support to Ukraine.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$20,111,729

Slogan:
Our Great American Comeback

Date of Candidacy Announcement:
May 24, 2023
"""),
        
        Candidate(name: "Larry Elder",
                  profilePic: UIImage(named: "larryelder")!,
                  party: "Republican",
                  title: "Lawyer and Talk Radio Host",
                  DOB: dateFormatter.date(from: "April 27, 1952")!,
                  website: URL(string: "https://www.larryelder.com/"),
                  originalBioLabel: "   Larry Elder was born on April 27, 1952 in Los Angeles, California (Age ##AGE##). He is a lawyer and talk radio host. He received a bachelor’s degree in political science from Brown University and a law degree from the University of Michigan School of Law. He worked as a private practice lawyer and founded Laurence A. Elder and Associates. He hosts a new media and talk radio show and his own Larry Elder show.",
                  stancesLabel: """
Gun Control:

He opposes gun control and is opposed to new policies.

Abortion:

Pro-life.

Environment:

Doesn't support consensus climate change or global warming and doesn't attribute wildfires to it.

Economy:

Against government welfare programs. Agrees with conservative economic policy and aims to crush inflation.

Immigration:

Supports law enforcement and tightened security on the US-Mexico border.

Other:

Has made anti-LGBTQ remarks and disagrees with the notion that America is systematically racist. Supports aid to Ukraine and increased diplomatic channels with Iran rather than confrontation.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$467,531

Slogan:
We've Got A Country To Save

Date of Candidacy Announcement:
April 20, 2023
"""),
        
        Candidate(name: "Nikki Haley",
                  profilePic: UIImage(named: "nikkihaley")!,
                  party: "Republican",
                  title: "Former Governor of South Carolina",
                  DOB: dateFormatter.date(from: "January 20, 1972")!,
                  website: URL(string: "https://nikkihaley.com/"),
                  originalBioLabel: "   Nikki Haley was born on January 20, 1972 in Bamberg, South Carolina (Age ##AGE##). She is a former Governor of South Carolina and a former House Representative. She received a bachelor’s degree in accounting from Clemson University in 1994 and is the former CFO of Exotica International. She was the U.N. Ambassador for the Trump administration from 2017 to 2018.",
                  stancesLabel: """
Gun Control:

Against gun control and the belief that guns are the issue.

Abortion:

Pro-life (opposes complete abortion ban).

Environment:

Believes in climate change and agrees that it is an issue to be addressed.

Economy:

Follows conservative economic policy and wants to keep taxes low.

Immigration:

Supports immigration law enforcement to crack down on illegal immigration.

Other:

Neutral on LGBTQ issues and supports voter ID laws. Also views China as a national threat.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$10,468,903

Slogan:
Stand For America

Date of Candidacy Announcement:
February 14, 2023
"""),
        
        Candidate(name: "Asa Hutchinson",
                  profilePic: UIImage(named: "asahutchinson")!,
                  party: "Republican",
                  title: "Former Governor of Arkansas",
                  DOB: dateFormatter.date(from: "December 3, 1950")!,
                  website: URL(string: "https://www.asa2024.com/"),
                  originalBioLabel: "    Asa Hutchinson was born on December 3, 1950 in Bentonville, Arkansas (Age ##AGE##). He is the former Governor of Arkansas. He has a B.S. in accounting from Bob Jones University and a J.D. from the University of Arkansas School of Law. He was a former city attorney and U.S. attorney under President Reagan. He is a former chairman of the Republican Party of Arkansas, and a former member of the U.S. House of Representatives, where he was one of 13 House managers during the impeachment trial of President Bill Clinton. He also was the undersecretary for border and transportation security in the USDHS in the George W. Bush administration, and he served as the former director of the Drug Enforcement Administration.",
                  stancesLabel: """
Gun Control:

He opposes increased gun control policies.

Abortion:

Pro-life.

Environment:

Does not support increased environmental regulations.

Economy:

Supports reducing government spending.

Immigration:

Supports increased security on the US-Mexico border and stricter immigration policies.

Other:

Opposed to LGBTQ policies. Supports reducing the number of federal employees by ten percent in order to reduce spending. Supports increasing U.S. involvement in Ukraine.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$582,521

Slogan:
For America's Best

Date of Candidacy Announcement:
April 2, 2023
"""),
        
        Candidate(name: "Perry Johnson",
                  profilePic: UIImage(named: "perryjohnson")!,
                  party: "Republican",
                  title: "Entrepreneur",
                  DOB: dateFormatter.date(from: "January 23, 1948")!,
                  website: URL(string: "https://www.perryjohnson.com/"),
                  originalBioLabel: "   Perry Johnson was born on January 23, 1948 in Dolton, Illinois (Age ##AGE##). He is an entrepreneur and author. He has a B.S. in Mathematics from the University of Illinois Urbana-Champaign. He has founded 80 companies and has written several books. He was also a candidate for the Republican nomination in the 2022 Michigan Gubernatorial election.",
                  stancesLabel: """
Gun Control:

N/A.

Abortion:

Pro-life.

Environment:

Does not support ending the country's dependence on fossil fuels and doesn't support climate-related regulations.

Economy:

Has a plan to combat debt by cutting two cents of every dollar spent yearly in federal discretionary spending.

Immigration:

Supports tightened border security and seriously combating illegal immigration. Supports only admitting immigrants who will address the country's needs, while making immigration easier for said vetted immigrants.

Other:

Supports abolishing the FBI and sees China as the greatest international threat to the U.S.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
N/A.

Slogan:
Two Cents To Save America

Date of Candidacy Announcement:
March 3, 2023
"""),
        
        Candidate(name: "Mike Pence",
                  profilePic: UIImage(named: "mikepence")!,
                  party: "Republican",
                  title: "48th Vice President of the U.S.",
                  DOB: dateFormatter.date(from: "June 7, 1959")!,
                  website: URL(string: "https://admin.mikepence2024.com/"),
                  originalBioLabel: "   Michael Richard Pence was born on June 7, 1959 in Columbus, Indiana (Age ##AGE##). He was the 48th Vice President of the United States under President Donald Trump, and he is a former Governor of Indiana. He has a BA from Hanover College and a JD from Indiana University, Indianapolis. He is a former lawyer and a former U.S. House Representative from Indiana, and he formerly chaired the House Republican Conference as well as the Republican Study Committee.",
                  stancesLabel: """
Gun Control:

He opposes new gun control policies and supports the Second Amendment.

Abortion:

Pro-life.

Environment:

Rejects scientific consensus on climate change.

Economy:

Supports lowering taxes and reducing spending with a focus on combating inflation.

Immigration:

Supports tightened border security and immigration policy.

Other:

In favor of increased support to Ukraine.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$1,168,733

Slogan:
Rediscover America's Promise

Date of Candidacy Announcement:
June 7, 2023
"""),
        
        Candidate(name: "Vivek Ramaswamy",
                  profilePic: UIImage(named: "vivekramaswamy")!,
                  party: "Republican",
                  title: "Entrepreneur",
                  DOB: dateFormatter.date(from: "August 9, 1985")!,
                  website: URL(string: "https://www.vivek2024.com/"),
                  originalBioLabel: "   Vivek Ganapathy Ramaswamy was born on August 9, 1985 in Cincinnati, (Age ##AGE##). He is an entrepreneur who founded the Roivant Sciences biotech company. He also co-founded Strive Asset Management. He has a B.A. from Harvard University and a J.D. from Yale University.",
                  stancesLabel: """
Gun Control:

He opposes increased gun control policies.

Abortion:

Pro-life, opposes federal abortion ban.

Environment:

Does not deny climate change but supports the use of more fossil fuels.

Economy:

Supports abolishing the IRS.

Immigration:

Supports a merit-based immigration system and increased security on the US-Mexico border.

Other:

Supports expanding presidential power and abolishing the Department of Education, FBI, and IRS. Supports raising voting age to 25 with exceptions. Supports economically separating from China and making concessions to Russia to end the war in Ukraine.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$19,152,444

Slogan:
A New American Dream

Date of Candidacy Announcement:
February 21, 2023
"""),
        
        Candidate(name: "Tim Scott",
                  profilePic: UIImage(named: "timscott")!,
                  party: "Republican",
                  title: "Senator from South Carolina",
                  DOB: dateFormatter.date(from: "September 19, 1965")!,
                  website: URL(string: "https://votetimscott.com/"),
                  originalBioLabel: "    Timothy Eugene Scott was born on September 19, 1965 in North Charleston, South Carolina (Age ##AGE##). He is the incumbent junior U.S. Senator from South Carolina. He has a BS from Charleston Southern University, and served as a member of Charleston County Council. He is a former South Carolina House Representative and former U.S. House Representative from South Carolina. He is a former Ranking Member of the Senate Aging Committee and a current Ranking Member of Senate Banking Committee.",
                  stancesLabel: """
Gun Control:

He opposes new gun control policies and supports the Second Amendment.

Abortion:

Pro-life.

Environment:

Accepts scientific consensus on climate change, but does not support increased environmental regulations.

Economy:

Supports lowering taxes and federal spending. Supports a Balanced Budget Amendment and FairTax proposal.

Immigration:

Supports cultural assimilation policies and opposes citizenship for undocumented immigrants.

Other:

Opposes same-sex marriage and has voiced support that the U.S. should aid pro-democracy groups in Iran.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$7,580,799

Slogan:
Faith in America

Date of Candidacy Announcement:
May 22, 2023
"""),
        
        Candidate(name: "Donald Trump",
                  profilePic: UIImage(named: "donaldtrump")!,
                  party: "Republican",
                  title: "45th President of the U.S.",
                  DOB: dateFormatter.date(from: "June 14, 1946")!,
                  website: URL(string: "https://www.donaldjtrump.com/"),
                  originalBioLabel: "   Donald John Trump was born on June 14, 1946 in New York City, New York (Age ##AGE##). He was the 45th President of the United States. He has a BS from the Wharton School of the University of Pennsylvania. He is also the owner of the Trump Organization.",
                  stancesLabel: """
Gun Control:

He opposes new gun control policies and supports the Second Amendment.

Abortion:

Pro-life.

Environment:

Rejects scientific consensus on climate change.

Economy:

Supports lowering taxes. Supports trade protectionism.

Immigration:

Supports tightened security on the U.S.-Mexico border.

Other:

Supports laws to combat election fraud.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
$32,164,175

Slogan:
Make America Great Again!

Date of Candidacy Announcement:
November 15, 2022
"""),
                      
        Candidate(name: "Cornel West",
                  profilePic: UIImage(named: "cornelwest")!,
                  party: "Independent",
                  title: "Philosopher and Political Activist",
                  DOB: dateFormatter.date(from: "June 2, 1953")!,
                  website: URL(string: "https://www.cornelwest24.org/"),
                  originalBioLabel: "    Cornel Ronald West was born on June 2, 1953 in Tulsa, Oklahoma (Age ##AGE##). He is a political activist and philosopher. He has a BA from Harvard University and an MA and PhD from Princeton University. He has held fellowships and professorships at those universities and several notable others. He is also a podcast co-host and commentator, and he has authored 20 books.",
                  stancesLabel: """
Gun Control:

He believes that gun control is not a priority. He would rather focus on addressing the root cause of gun violence instead.

Abortion:

Pro-choice.

Environment:

Big supporter of "Green New Deal" and renewable energy.

Economy:

Supports workers rights, living wages for all jobs, and medicare for all.

Immigration:

Supports improved treatment for all asylum-seekers.

Other:

Supports LGBTQ and Trans rights, supports eliminating the Electoral College and making election day a holiday, opposes growing U.S. involvement in Ukraine and supports increased diplomacy.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
N/A.

Slogan:
Justice is what love looks like in public

Date of Candidacy Announcement:
June 5, 2023
"""),
        
        Candidate(name: "Chase Oliver",
                  profilePic: UIImage(named: "chaseoliver")!,
                  party: "Libertarian",
                  title: "Political Activist",
                  DOB: dateFormatter.date(from: "August 16, 1985")!,
                  website: URL(string: "https://www.votechaseoliver.com/"),
                  originalBioLabel: "    Chase Oliver was born on August 16, 1985 in Nashville, Tennessee (Age 38). He is a political activist. He attended Georgia State University and formerly worked in the import shipping business. He ran in the U.S. Senate election in Georgia in 2022 and ran in the special election for Georgia’s 5th Congressional District in 2020.",
                  stancesLabel: """
Gun Control:

Supports gun rights.

Abortion:

Pro-choice.

Environment:

Supports a free-market solution to climate change. If businesses are left alone, they will find a fix themselves.

Economy:

Supports a much more open market and cutting spending.

Immigration:

Supports laws to simplify and improve the immigration system.

Other:

Supports taking a more peaceful and diplomatic stance in world affairs rather than constant intervention.
""",
                  campaignLabel: """
Campaign Spending (Receipts):
N/A.

Slogan:
N/A

Date of Candidacy Announcement:
April 4, 2023
"""),
        ]
    return candidates
}



