module Stupidedi
  using Refinements

  module Guides
    module FiftyTen
      module X212

        b = GuideBuilder
        d = Schema
        r = SegmentReqs
        e = ElementReqs
        s = Versions::FunctionalGroups::FiftyTen::SegmentDefs
        t = Versions::FunctionalGroups::FiftyTen::TransactionSetDefs

        #
        # Health Care Claim Acknowledgement
        #
        VALUES_FOR_2200D_STC01_03 = ["03", "13", "17", "1E", "1G", "1H", "1I", "1O", "1P", "1Q", "1R", "1S", "1T",
                "1U", "1V", "1W", "1X", "1Y", "1Z", "28", "2A", "2B", "2D", "2E", "2I", "2K",
                "2P", "2Q", "2S", "2Z", "30", "36", "3A", "3C", "3D", "3E", "3F", "3G", "3H",
                "3I", "3J", "3K", "3L", "3M", "3N", "3O", "3P", "3Q", "3R", "3S", "3T", "3U",
                "3V", "3W", "3X", "3Y", "3Z", "40", "43", "44", "4A", "4B", "4C", "4D", "4E",
                "4F", "4G", "4H", "4I", "4J", "4L", "4M", "4N", "4O", "4P", "4Q", "4R", "4S",
                "4U", "4V", "4W", "4X", "4Y", "4Z", "5A", "5B", "5C", "5D", "5E", "5F", "5G",
                "5H", "5I", "5J", "5K", "5L", "5M", "5N", "5O", "5P", "5Q", "5R", "5S", "5T",
                "5U", "5V", "5W", "5X", "5Y", "5Z", "61", "6A", "6B", "6C", "6D", "6E", "6F",
                "6G", "6H", "6I", "6J", "6K", "6L", "6M", "6N", "6O", "6P", "6Q", "6R", "6S",
                "6U", "6V", "6W", "6X", "6Y", "71", "72", "73", "74", "77", "7C", "80", "82",
                "84", "85", "87", "95", "CK", "CZ", "D2", "DD", "DJ", "DK", "DN", "DO", "DQ",
                "E1", "E2", "E7", "E9", "FD", "FE", "G0", "GB", "GI", "GJ", "GK", "GM", "GY",
                "HF", "HH", "I3", "IL", "IN", "LI", "LR", "MR", "MSC", "OB", "OD", "OX", "P0",
                "P2", "P3", "P4", "P6", "P7", "PRP", "PT", "PV", "PW", "TL", "TQ", "TT", "TTP",
                "TU", "UH", "X3", "X4", "X5", "ZZ"]

        HN277 = b.build(t::HN277,
          d::TableDef.header("Table 1 - Header",
            b::Segment(100, s::ST, "Transaction Set Header",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Transaction Set Identifier Code", b::Values("277")),
              b::Element(e::Required,    "Transaction Set Control Number"),
              b::Element(e::Required,    "Version, Release, or Industry Identifier", b::Values("005010X212"))),
            b::Segment(200, s::BHT, "Beginning of Hierarchical Transaction",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Hierarchical Structure Code", b::Values("0010")),
              b::Element(e::Required,    "Transaction Set Purpose Code", b::Values("08")),
              b::Element(e::Required,    "Originator Application Transaction Identifier", b::MaxLength(30)),
              b::Element(e::Required,    "Transaction Set Creation Date"),
              b::Element(e::Required,    "Transaction Set Creation Time"),
              b::Element(e::Required,    "Transaction Type Code", b::Values("DG")))),

          d::TableDef.detail("Table 2 - Information Source Detail",
            d::LoopDef.build("2000A INFORMATION SOURCE LEVEL",
              d::RepeatCount.bounded(1),
              b::Segment(100, s::HL, "Information Source Level",
                r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Required,    "Hierarchical ID Number"),
                b::Element(e::NotUsed,     "Hierarchical Parent ID Number"),
                b::Element(e::Required,    "Hierarchical Level Code", b::Values("20")),
                b::Element(e::Required,    "Hierachical Child Code", b::Values("1"))),

              d::LoopDef.build("2100A INFORMATION SOURCE NAME",
                d::RepeatCount.bounded(1),
                b::Segment(500, s::NM1, "Information Source Name",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Entity Identifier Code", b::Values("PR")), # was: "AY", "PR"
                  b::Element(e::Required,    "Entity Type Qualifier", b::Values("2")),
                  b::Element(e::Required,    "Information Source Name"),
                  b::Element(e::NotUsed,     "Name First"),
                  b::Element(e::NotUsed,     "Name Middle"),
                  b::Element(e::NotUsed,     "Name Prefix"),
                  b::Element(e::NotUsed,     "Name Suffix"),
                  b::Element(e::Required,    "Identification Code Qualifier", b::Values("PI", "XV")), # was: "46", "FI"
                  b::Element(e::Required,    "Information Source Identifier"),
                  b::Element(e::NotUsed,     "Entity Relationship Code"),
                  b::Element(e::NotUsed,     "Entity Identifier Code"),
                  b::Element(e::NotUsed,     "Name Last or Organization Name"))))),

                # Should be a PER segment here, but let's skip it and see what happens.

          d::TableDef.detail("Table 2 - Information Receiver Detail",
            d::LoopDef.build("2000B INFORMATION RECEIVER LEVEL",
              d::RepeatCount.bounded(1),
              b::Segment(100, s::HL, "Information Receiver Level",
                r::Required, d::RepeatCount.bounded(1),
                b::Element(e::Required,    "Hierarchical ID Number"),
                b::Element(e::Required,    "Hierarchical Parent ID Number"),
                b::Element(e::Required,    "Hierarchical Level Code", b::Values("21")),
                b::Element(e::Required,    "Hierachical Child Code", b::Values("0", "1"))),

              d::LoopDef.build("2100B INFORMATION RECEIVER NAME",
                d::RepeatCount.bounded(1),
                b::Segment(500, s::NM1, "Information Receiver Name",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Entity Identifier Code", b::Values("41")),
                  b::Element(e::Required,    "Entity Type Qualifier", b::Values("1", "2")),
                  b::Element(e::Required,    "Information Receiver Last or Organizational Name"),
                  b::Element(e::Situational, "Information Receiver First Name"),
                  b::Element(e::Situational, "Information Receiver Middle Name or Initial"),
                  b::Element(e::NotUsed,     "Name Prefix"),
                  b::Element(e::NotUsed,     "Name Suffix"),
                  b::Element(e::Required,    "Identification Code Qualifier", b::Values("46")),
                  b::Element(e::Required,    "Information Receiver Primary Identifier"),
                  b::Element(e::NotUsed,     "Entity Relationship Code"),
                  b::Element(e::NotUsed,     "Entity Identifier Code"),
                  b::Element(e::NotUsed,     "Name Last or Organization Name"))),

              d::LoopDef.build("2200B INFORMATION RECEIVER APPLICATION TRACE IDENTIFIER",
                d::RepeatCount.bounded(1),
                b::Segment( 900, s::TRN, "Information Receiver Application Trace Identifier",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Trace Type Code", b::Values("2")),
                  b::Element(e::Required,    "Claim Transaction Batch Number"),
                  b::Element(e::NotUsed,     "Originating Company Identifier"),
                  b::Element(e::NotUsed,     "Reference Identification")),
                b::Segment(1000, s::STC, "Information Receiver Status Information",
                  r::Required, d::RepeatCount.unbounded,
                  b::Element(e::Required,    "HEALTH CARE CLAIM STATUS",
                    b::Element(e::Required,    "Health Care Claim Status Category Code"), # @todo: CodeSource.external("507")
                    b::Element(e::Required,    "Health Care Claim Status Code"),          # @todo: CodeSource.external("508")
                    b::Element(e::Situational, "Entity Identifier Qualifier", b::Values("41", "AY", "PR")),
                    b::Element(e::NotUsed,     "Code List Qualifier Code")),
                  b::Element(e::NotUsed,     "Status Information Effective Date"),
                  b::Element(e::NotUsed,     "Action Code"),
                  b::Element(e::NotUsed,     "Total Submitted Charges for Unit Work"),
                  b::Element(e::NotUsed,     "Monetary Amount"),
                  b::Element(e::NotUsed,     "Date"),
                  b::Element(e::NotUsed,     "Payment Method Code"),
                  b::Element(e::NotUsed,     "Date"),
                  b::Element(e::NotUsed,     "Check Number"),
                  b::Element(e::Situational, "HEALTH CARE CLAIM STATUS",
                    b::Element(e::Required,    "Health Care Claim Status Category Code"), # @todo: CodeSource.external("507")
                    b::Element(e::Required,    "Health Care Claim Status Code"),          # @todo: CodeSource.external("508")
                    b::Element(e::Situational, "Entity Identifier Qualifier", b::Values("41", "AY", "PR")),
                    b::Element(e::NotUsed,     "Code List Qualifier Code")),
                  b::Element(e::Situational, "HEALTH CARE CLAIM STATUS",
                    b::Element(e::Required,    "Health Care Claim Status Category Code"), # @todo: CodeSource.external("507")
                    b::Element(e::Required,    "Health Care Claim Status Code"),          # @todo: CodeSource.external("508")
                    b::Element(e::Situational, "Entity Identifier Qualifier", b::Values("41", "AY", "PR")),
                    b::Element(e::NotUsed,     "Code List Qualifier Code")),
                  b::Element(e::NotUsed,     "Free-form Message Text"))))),

          d::TableDef.detail("Table 2 - Billing Provider of Service Detail",
            d::LoopDef.build("2000C BILLING PROVIDER OF SERVICE LEVEL",
              d::RepeatCount.bounded(1),
              b::Segment(100, s::HL, "Billing Provider of Service Level",
                r::Situational, d::RepeatCount.bounded(1),
                b::Element(e::Required,    "Hierarchical ID Number"),
                b::Element(e::Required,    "Hierarchical Parent ID Number"),
                b::Element(e::Required,    "Hierarchical Level Code", b::Values("19")),
                b::Element(e::Required,    "Hierachical Child Code", b::Values("0", "1"))),

              d::LoopDef.build("2100C BILLING PROVIDER NAME",
                d::RepeatCount.unbounded,
                b::Segment(500, s::NM1, "Billing Provider Name",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Entity Identifier Code", b::Values("1P")),
                  b::Element(e::Required,    "Entity Type Qualifier", b::Values("1", "2")),
                  b::Element(e::Required,    "Billing Provider Last or Organizational Name"),
                  b::Element(e::Situational, "Billing Provider First Name"),
                  b::Element(e::Situational, "Billing Provider Middle Name or Initial"),
                  b::Element(e::NotUsed,     "Name Prefix"),
                  b::Element(e::Situational, "Billing Provider Name Suffix"),
                  b::Element(e::Required,    "Identification Code Qualifier", b::Values("FI", "SV", "XX")),
                  b::Element(e::Required,    "Billing Provider Identifier"),
                  b::Element(e::NotUsed,     "Entity Relationship Code"),
                  b::Element(e::NotUsed,     "Entity Identifier Code"),
                  b::Element(e::NotUsed,     "Name Last or Organization Name"))),

              d::LoopDef.build("2200C PROVIDER OF SERVICE INFORMATION TRACE IDENTIFIER",
                d::RepeatCount.bounded(1),
                b::Segment( 900, s::TRN, "Provider of Service Information Trace Identifier",
                  r::Situational, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Trace Type Code", b::Values("1")),
                  b::Element(e::Required,    "Provider of Service Information Trace Identifier"),
                  b::Element(e::NotUsed,     "Originating Company Identifier"),
                  b::Element(e::NotUsed,     "Reference Identification")),
                b::Segment(1000, s::STC, "Billing Provider Status Information",
                  r::Situational, d::RepeatCount.unbounded,
                  b::Element(e::Required,    "HEALTH CARE CLAIM STATUS",
                    b::Element(e::Required,    "Health Care Claim Status Category Code"), # @todo: CodeSource.external("507")
                    b::Element(e::Required,    "Health Care Claim Status Code"),          # @todo: CodeSource.external("508")
                    b::Element(e::Situational, "Entity Identifier Qualifier", b::Values("1P")),
                    b::Element(e::NotUsed,     "Code List Qualifier Code")),
                  b::Element(e::NotUsed,     "Date"),
                  b::Element(e::NotUsed,     "Action Code"),
                  b::Element(e::NotUsed,     "Monetary Amount"),
                  b::Element(e::NotUsed,     "Monetary Amount"),
                  b::Element(e::NotUsed,     "Date"),
                  b::Element(e::NotUsed,     "Payment Method Code"),
                  b::Element(e::NotUsed,     "Date"),
                  b::Element(e::NotUsed,     "Check Number"),
                  b::Element(e::Situational, "HEALTH CARE CLAIM STATUS",
                    b::Element(e::Required,    "Health Care Claim Status Category Code"), # @todo: CodeSource.external("507")
                    b::Element(e::Required,    "Health Care Claim Status Code"),          # @todo: CodeSource.external("508")
                    b::Element(e::Situational, "Entity Identifier Qualifier", b::Values("36", "40", "41", "AY", "PR")),
                    b::Element(e::NotUsed,     "Code List Qualifier Code")),
                  b::Element(e::Situational, "HEALTH CARE CLAIM STATUS",
                    b::Element(e::Required,    "Health Care Claim Status Category Code"), # @todo: CodeSource.external("507")
                    b::Element(e::Required,    "Health Care Claim Status Code"),          # @todo: CodeSource.external("508")
                    b::Element(e::Situational, "Entity Identifier Qualifier", b::Values("36", "40", "41", "AY", "PR")),
                    b::Element(e::NotUsed,     "Code List Qualifier Code")),
                  b::Element(e::NotUsed,     "Free-form Message Text"))))),

          d::TableDef.detail("Table 2 - Patient Detail",
            d::LoopDef.build("2000D PATIENT LEVEL",
              d::RepeatCount.bounded(1),
              b::Segment(100, s::HL, "Patient Level",
                r::Situational, d::RepeatCount.bounded(1),
                b::Element(e::Required,    "Hierarchical ID Number"),
                b::Element(e::Required,    "Hierarchical Parent ID Number"),
                b::Element(e::Required,    "Hierarchical Level Code", b::Values("22")),
                b::Element(e::NotUsed,     "Hierachical Child Code")),

              d::LoopDef.build("2100D PATIENT NAME",
                d::RepeatCount.bounded(1),
                b::Segment(500, s::NM1, "Subscriber Name",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Entity Identifier Code", b::Values("IL")),
                  b::Element(e::Required,    "Entity Type Qualifier", b::Values("1", "2")),
                  b::Element(e::Required,    "Patient Last or Organizational Name"),
                  b::Element(e::Situational, "Patient First Name"),
                  b::Element(e::Situational, "Patient Middle Name or Initial"),
                  b::Element(e::NotUsed,     "Name Prefix"),
                  b::Element(e::Situational, "Patient Name Suffix"),
                  b::Element(e::Required,    "Identification Code Qualifier", b::Values("24", "II", "MI")),
                  b::Element(e::Required,    "Patient Identification Number"),
                  b::Element(e::NotUsed,     "Entity Relationship Code"),
                  b::Element(e::NotUsed,     "Entity Identifier Code"),
                  b::Element(e::NotUsed,     "Name Last or Organization Name"))),

              d::LoopDef.build("2200D CLAIM STATUS TRACKING NUMBER",
                d::RepeatCount.unbounded,
                b::Segment( 900, s::TRN, "Claim Status Tracking Number",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Trace Type Code", b::Values("2")),
                  b::Element(e::Required,    "Patient Control Number"),
                  b::Element(e::NotUsed,     "Originating Company Identifier"),
                  b::Element(e::NotUsed,     "Reference Identification")),
                b::Segment(1000, s::STC, "Claim Level Status Information",
                  r::Required, d::RepeatCount.unbounded,
                  b::Element(e::Required,    "HEALTH CARE CLAIM STATUS",
                    b::Element(e::Required,    "Health Care Claim Status Category Code"), # @todo: CodeSource.external("507")
                    b::Element(e::Required,    "Health Care Claim Status Code"),          # @todo: CodeSource.external("508")
                    b::Element(e::Situational, "Entity Identifier Qualifier", b::Values(*VALUES_FOR_2200D_STC01_03)),
                    b::Element(e::Situational,     "Code List Qualifier Code")),
                  b::Element(e::Required,    "Status Information Effective Date"),
                  b::Element(e::NotUsed,     "Action Code"),
                  b::Element(e::Situational, "Total Claim Charge Amount"),
                  b::Element(e::Situational, "Claim Payment Amount"),
                  b::Element(e::Situational, "Adjudication Finalized Date"),
                  b::Element(e::NotUsed,     "Payment Method Code"),
                  b::Element(e::Situational, "Remittance Date"),
                  b::Element(e::Situational, "Check Number"),
                  b::Element(e::Situational, "HEALTH CARE CLAIM STATUS",
                    b::Element(e::Required,    "Health Care Claim Status Category Code"), # @todo: CodeSource.external("507")
                    b::Element(e::Required,    "Health Care Claim Status Code"),          # @todo: CodeSource.external("508")
                    b::Element(e::Situational, "Entity Identifier Qualifier", b::Values(*VALUES_FOR_2200D_STC01_03)),
                    b::Element(e::Situational, "Code List Qualifier Code")),
                  b::Element(e::Situational, "HEALTH CARE CLAIM STATUS",
                    b::Element(e::Required,    "Health Care Claim Status Category Code"), # @todo: CodeSource.external("507")
                    b::Element(e::Required,    "Health Care Claim Status Code"),          # @todo: CodeSource.external("508")
                    b::Element(e::Situational, "Entity Identifier Qualifier", b::Values(*VALUES_FOR_2200D_STC01_03)),
                    b::Element(e::Situational, "Code List Qualifier Code")),
                  b::Element(e::Situational, "Free Form Message Text")),
                b::Segment(1100, s::REF, "Payer Claim Control Number",
                  r::Situational, d::RepeatCount.bounded(3),
                  b::Element(e::Required,    "Reference Identification Qualifier", b::Values("1K")),
                  b::Element(e::Required,    "Payer Claim Control Number"),
                  b::Element(e::NotUsed,     "Description"),
                  b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                b::Segment(1100, s::REF, "Institutional Bill Type Identification",
                  r::Situational, d::RepeatCount.bounded(3),
                  b::Element(e::Required,    "Reference Identification Qualifier", b::Values("BLT")),
                  b::Element(e::Required,    "Institutional Bill Type Identification"),
                  b::Element(e::NotUsed,     "Description"),
                  b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                b::Segment(1100, s::REF, "Claim Status Tracking Number",
                  r::Situational, d::RepeatCount.bounded(3),
                  b::Element(e::Required,    "Reference Identification Qualifier", b::Values("EJ")),
                  b::Element(e::Required,    "Patient Control Number"),
                  b::Element(e::NotUsed,     "Description"),
                  b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                b::Segment(1300, s::DTP, "Claim Level Service Date",
                  r::Required, d::RepeatCount.bounded(1),
                  b::Element(e::Required,    "Date Time Qualifier", b::Values("472")),
                  b::Element(e::Required,    "Date Time Period Format Qualifier", b::Values("D8", "RD8")),
                  b::Element(e::Required,    "Claim Service Period"))),

                d::LoopDef.build("2220D SERVICE LINE INFORMATION", # not checking this guy super thoroughly b/c it isn't
                  d::RepeatCount.unbounded, #                        in our example cases
                  b::Segment(1800, s::SVC, "Service Line Information",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "COMPOSITE MEDICAL PROCEDURE IDENTIFIER",
                      b::Element(e::Required,    "Procedure Code", b::Values("AD", "ER", "HC", "HP", "IV", "NU", "WK")),
                      b::Element(e::Required,    "Procedure Code"),
                      b::Element(e::Situational, "Procedure Modifier"),
                      b::Element(e::Situational, "Procedure Modifier"),
                      b::Element(e::Situational, "Procedure Modifier"),
                      b::Element(e::Situational, "Procedure Modifier"),
                      b::Element(e::NotUsed,     "Description"),
                      b::Element(e::NotUsed,     "Product/Service ID")),
                    b::Element(e::Required,    "Line Item Charge Amount"),
                    b::Element(e::NotUsed,     "Monetary Amount"),
                    b::Element(e::Situational, "Revenue Code"),
                    b::Element(e::NotUsed,     "Quantity"),
                    b::Element(e::NotUsed,     "COMPOSITE MEDICAL PROCEDURE IDENTIFIER"),
                    b::Element(e::Situational, "Original Units of Service Count")),
                  b::Segment(1900, s::STC, "Service Line Level Status Information",
                    r::Required, d::RepeatCount.unbounded,
                    b::Element(e::Required,    "HEALTH CARE CLAIM STATUS",
                      b::Element(e::Required,    "Health Care Claim Status Category Code"), # @todo: CodeSource.external("507")
                      b::Element(e::Required,    "Health Care Claim Status Code"),          # @todo: CodeSource.external("508")
                      b::Element(e::Situational, "Entity Identifier Qualifier", b::Values("03", "1P", "1Z", "40", "41", "71", "72", "73", "77", "82", "85", "87", "DK", "DN", "DQ", "FA", "GB", "HK", "IL", "LI", "MSC", "PR", "PRP", "QB", "QC", "QD", "SEP", "TL", "TTP", "TU")),
                      b::Element(e::NotUsed,     "Code List Qualifier Code")),
                    b::Element(e::NotUsed,     "Date"),
                    b::Element(e::Required,    "Action Code", b::Values("U")),
                    b::Element(e::NotUsed,     "Monetary Amount"),
                    b::Element(e::NotUsed,     "Monetary Amount"),
                    b::Element(e::NotUsed,     "Date"),
                    b::Element(e::NotUsed,     "Payment Method Code"),
                    b::Element(e::NotUsed,     "Date"),
                    b::Element(e::NotUsed,     "Check Number"),
                    b::Element(e::Situational, "HEALTH CARE CLAIM STATUS",
                      b::Element(e::Required,    "Health Care Claim Status Category Code"), # @todo: CodeSource.external("507")
                      b::Element(e::Required,    "Health Care Claim Status Code"),          # @todo: CodeSource.external("508")
                      b::Element(e::Situational, "Entity Identifier Qualifier", b::Values("36", "40", "41", "AY", "PR")),
                      b::Element(e::NotUsed,     "Code List Qualifier Code")),
                    b::Element(e::Situational, "HEALTH CARE CLAIM STATUS",
                      b::Element(e::Required,    "Health Care Claim Status Category Code"), # @todo: CodeSource.external("507")
                      b::Element(e::Required,    "Health Care Claim Status Code"),          # @todo: CodeSource.external("508")
                      b::Element(e::Situational, "Entity Identifier Qualifier", b::Values("36", "40", "41", "AY", "PR")),
                      b::Element(e::NotUsed,     "Code List Qualifier Code")),
                    b::Element(e::Situational, "Free Form Message Text")),
                  b::Segment(2000, s::REF, "Service Line Item Identification",
                    r::Required, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("FJ")),
                    b::Element(e::Required,    "Line Item Control Number"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(2000, s::REF, "Pharmacy Prescription Number",
                    r::Situational, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Reference Identification Qualifier", b::Values("XZ")),
                    b::Element(e::Required,    "Pharmacy Prescription Number"),
                    b::Element(e::NotUsed,     "Description"),
                    b::Element(e::NotUsed,     "REFERENCE IDENTIFIER")),
                  b::Segment(2100, s::DTP, "Service Line Date",
                    r::Required, d::RepeatCount.bounded(1),
                    b::Element(e::Required,    "Date Time Qualifier", b::Values("472")),
                    b::Element(e::Required,    "Date Time Period Format Qualifier", b::Values("D8", "RD8")),
                    b::Element(e::Required,    "Service Line Date"))))),

          d::TableDef.detail("Table 3 - Summary",
            b::Segment(2700, s::SE, "Transaction Set Trailer",
              r::Required, d::RepeatCount.bounded(1),
              b::Element(e::Required,    "Transaction Segment Count"),
              b::Element(e::Required,    "Transaction Set Control Number"))))

      end
    end
  end
end
