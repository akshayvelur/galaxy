import '../models/faq_item.dart';

class FaqData {
  static const List<FAQItem> faqs = [
    FAQItem(
      question: 'What vehicles do you provide?',
      answer:
          'We operate a dedicated modern fleet consisting of: 16-Seat Force Luxury Travellers, 18-Seat Extended Force Travellers, and 26-Seat Luxury Tourist Coaches. All vehicles feature high-capacity air-conditioning, executive push-back recliner seats, generous luggage boot space, USB charging ports, and certified highway drivers.',
      category: 'Vehicles',
    ),
    FAQItem(
      question: 'Do you provide tours throughout India?',
      answer:
          'Yes! We hold All India Tourist Permits (AITP) and operate across North India (Himachal, Kashmir, Golden Triangle, Uttarakhand), South India (Kerala, Tamil Nadu, Karnataka, Goa), West India (Rajasthan, Gujarat, Maharashtra), and East/Northeast India (Sikkim, Meghalaya, Assam).',
      category: 'Destinations',
    ),
    FAQItem(
      question: 'Can we customize the itinerary?',
      answer:
          'Absolutely! Every group has unique preferences. You can customize days, route halts, sightseeing points, hotel categories (3-star, 4-star, or luxury heritage), meal plans, and vehicle choices. Simply share your ideas via our enquiry form or WhatsApp.',
      category: 'Customization',
    ),
    FAQItem(
      question: 'Can we choose our own travel dates?',
      answer:
          'Yes, 100%. Our tours are private group tours tailored around your schedule. You can select your preferred departure date, duration, and pickup timings any day of the year.',
      category: 'Booking',
    ),
    FAQItem(
      question: 'Do you provide pickup and drop services?',
      answer:
          'Yes. We provide door-to-door, airport, and railway station pickup and drop-off services across all major Indian transit hubs including Delhi, Kochi, Bangalore, Mumbai, Chennai, Jaipur, and Chandigarh.',
      category: 'Services',
    ),
    FAQItem(
      question: 'Are hotels included in tour packages?',
      answer:
          'We offer both Complete Tour Packages (Vehicle + Handpicked Hotels + Breakfast + Sightseeing) and Vehicle-Only Rentals. You can choose the package option that suits your preference. Our hotel partners are thoroughly vetted for hygiene, family safety, and parking accessibility.',
      category: 'Packages',
    ),
    FAQItem(
      question: 'How can I get a quotation?',
      answer:
          'You can get an instant personalized quotation by clicking "Get a Quote" on the home page, filling our Booking Enquiry form, or clicking our WhatsApp button to connect directly with our tour planning team. We provide transparent, itemized quotes with zero hidden charges.',
      category: 'Pricing',
    ),
    FAQItem(
      question: 'How can I contact the driver?',
      answer:
          'Once your booking is confirmed, complete driver details (name, photo, phone number, vehicle registration number, and live GPS tracking link) are shared with you 24 hours prior to departure via WhatsApp and SMS.',
      category: 'Support',
    ),
  ];
}
