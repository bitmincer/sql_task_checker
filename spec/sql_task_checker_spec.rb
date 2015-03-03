require_relative '../sql_task_checker'

describe SqlTaskChecker do
  describe '#check' do
    before do
      allow(SqlTaskChecker).to receive(:config).and_return(YAML.load_file('database.yml')['test'])
    end

    let(:checker_sql) { 'SELECT * FROM articles;' }

    subject { described_class.check(checker_sql: checker_sql, user_sql: user_sql) }

    context 'valid params' do
      let(:user_sql) { 'SELECT * FROM articles;' }

      it 'is valid' do
        expect(subject[:result]).to eq true
      end

      it "hasn't errors" do
        expect(subject[:error]).to eq nil
      end
    end

    context 'wrong query' do
      let(:user_sql) { 'SELECT * FROM articles WHERE id > 1;' }

      it 'is invalid' do
        expect(subject[:result]).to eq false
      end

      it "hasn't errors" do
        expect(subject[:error]).to eq nil
      end
    end

    context 'sql syntax error' do
      let(:user_sql) { 'SELECT * FRxxxxOM articles;' }

      it 'is invalid' do
        expect(subject[:result]).to eq false
      end

      it "hasn't errors" do
        expect(subject[:error]).to include 'ERROR:  syntax error'
      end
    end

    context 'permission violation' do
      let(:user_sql) { "INSERT INTO articles(name) VALUES ('name');" }\

      it 'is invalid' do
        expect(subject[:result]).to eq false
      end

      it "hasn't errors" do
        expect(subject[:error]).to include 'ERROR:  permission denied for relation articles'
      end
    end
  end
end
