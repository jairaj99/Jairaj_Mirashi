     package spi_pkg;

        /*Import uvm_pkg.sv*/
                import uvm_pkg::*;

        // Include uvm_macros.sv
                `include "uvm_macros.svh"
                `include "spi_m_agent_config.sv"
                `include "spi_s_agent_config.sv"

                `include "ctrl_reg.sv"
                `include "rxtx_reg.sv"
                `include "ss_reg.sv"
                `include "divider_reg.sv"
                `include "spi_reg_block.sv"

                `include "env_config.sv"
                `include "spi_m_xtn.sv"
                `include "spi_m_sequencer.sv"
                `include "spi_m_driver.sv"
                `include "spi_m_monitor.sv"
                `include "spi_m_agent.sv"
                `include "spi_m_agent_top.sv"
                `include "spi_reg_seq.sv"
                `include "spi_sequence.sv"

                `include "spi_s_xtn.sv"
                `include "spi_s_sequencer.sv"
                `include "spi_s_driver.sv"
                `include "spi_s_monitor.sv"
                `include "spi_s_agent.sv"
                `include "spi_s_agent_top.sv"
		      `include "slave_sequence.sv"
                `include "adapter.sv"

                `include "virtual_seqr.sv"
                `include "scoreboard.sv"
                `include "env.sv"
                `include "virtual_seq.sv"

                `include "spi_base_test.sv"

        endpackage
